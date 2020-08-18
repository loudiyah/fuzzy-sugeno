<?php
error_reporting(~E_NOTICE);
session_start();

include 'config.php';
include 'includes/db.php';
$db = new DB($config['server'], $config['username'], $config['password'], $config['database_name']);
include 'includes/general.php';

$mod = $_GET['m'];
$act = $_GET['act'];

$nRI = array(
    1 => 0,
    2 => 0,
    3 => 0.58,
    4 => 0.9,
    5 => 1.12,
    6 => 1.24,
    7 => 1.32,
    8 => 1.41,
    9 => 1.46,
    10 => 1.49
);

$rows = $db->get_results("SELECT kode_alternatif, nama_alternatif FROM tb_alternatif ORDER BY kode_alternatif");
foreach ($rows as $row) {
    $ALTERNATIF[$row->kode_alternatif] = $row->nama_alternatif;
}

$rows = $db->get_results("SELECT * FROM tb_himpunan ORDER BY kode_himpunan");
$HIMPUNAN = array();
$KRITERIA_HIMPUNAN = array();
foreach ($rows as $row) {
    $HIMPUNAN[$row->kode_himpunan] = $row;
    $KRITERIA_HIMPUNAN[$row->kode_kriteria][$row->kode_himpunan] = $row;
}

$rows = $db->get_results("SELECT * FROM tb_kriteria ORDER BY kode_kriteria");
foreach ($rows as $row) {
    $KRITERIA[$row->kode_kriteria] = $row;
}

/** ============================== */
function get_relasi()
{
    global $db;
    $data = array();
    $rows = $db->get_results("SELECT * FROM tb_rel_alternatif ORDER BY kode_alternatif, kode_kriteria");
    foreach ($rows as $row) {
        $data[$row->kode_alternatif][$row->kode_kriteria] = $row->nilai;
    }
    return $data;
}

function get_nilai($data = array())
{
    global $KRITERIA_HIMPUNAN, $KRITERIA;

    $arr = array();
    //echo '<pre>' . print_r($data, 1) . '</pre>';                
    foreach ($data as $key => $val) {
        foreach ($val as $k => $v) {
            foreach ($KRITERIA_HIMPUNAN[$k] as $a => $b) {
                $ba = $KRITERIA[$k]->batas_atas;
                $bb = $KRITERIA[$k]->batas_bawah;

                $n1 = $b->n1;
                $n2 = $b->n2;
                $n3 = $b->n3;
                $n4 = $b->n4;

                if ($v <= $n1)
                    $nilai = 0;
                else if ($v >= $n1 && $v <= $n2)
                    $nilai = ($v - $n1) / ($n2 - $n1);
                else if ($v >= $n2 && $v <= $n3)
                    $nilai = 1;
                else if ($v >= $n3 && $v <= $n4)
                    $nilai = ($n4 - $v) / ($n4 - $n3);
                else
                    $nilai = 0;

                if ($v >= $ba && ($n3 >= $ba || $n4 >= $ba))
                    $nilai = 1;

                if ($v <= $bb && ($n1 <= $bb || $n2 <= $bb))
                    $nilai = 1;

                $arr[$key][$k][$a] = $nilai;
            }
        }
    }

    //echo '<pre>' . print_r($arr, 1) . '</pre>';

    return $arr;
}

function get_min($nilai, $aturan)
{
    $data = array();
    $arr = array();

    foreach ($nilai as $key => $val) {
        foreach ($aturan as $k => $v) {
            foreach ($v['item'] as $a => $b) {
                $data[$k][$key][] = $val[$a][$b];
            }
        }
    }

    foreach ($data as $key => $val) {
        foreach ($val as $k => $v) {
            $arr[$key][$k] = min($v);
        }
    }
    return $arr;
}

function get_total($aturan, $min)
{
    $data = array();

    foreach ($min as $key => $val) {
        foreach ($val as $k => $v) {
            $data[$k]['x'] += $v * $aturan[$key]['nilai'];
            $data[$k]['y'] += $v;
        }
    }

    foreach ($data as $key => $val) {
        $arr[$key] = $val['x'] / $val['y'];
    }

    return $arr;
}

function save_rules($nilai = array())
{
    global $db;

    $rules = get_rules();
    foreach ($nilai as $key => $val) {
        $rules[$key]['nilai'] = $val;
    }

    $str_arr = serialize($rules);
    $db->query("REPLACE tb_rule (ID, aturan) VALUES(1, '$str_arr')");
    //echo '<pre>' . print_r($rules, 1) . '</pre>';
}

function generate_rules($arr, $rule)
{
    if ($arr) {
        end($arr);
        $kode_kriteria = key($arr);
        if ($rule) {
            $new_rule = array();
            foreach ($arr[$kode_kriteria] as $key => $val) {
                foreach ($rule as $k => $v) {
                    $new_rule[] = array_merge(array($kode_kriteria => $key), $v);
                }
            }
            $rule = $new_rule;
        } else {
            foreach ($arr[$kode_kriteria] as $key => $val) {
                $rule[][$kode_kriteria] = $key;
            }
        }
        unset($arr[$kode_kriteria]);
        return generate_rules($arr, $rule);
    } else {
        return $rule;
    }
}

function get_rules()
{
    global $db;
    $var = $db->get_var("SELECT aturan FROM tb_rule LIMIT 1");
    $rules_saved =  unserialize($var);

    $rows = $db->get_results("SELECT * FROM tb_himpunan ORDER BY kode_kriteria, kode_himpunan");
    $arr = array();
    foreach ($rows as $row) {
        $arr[$row->kode_kriteria][$row->kode_himpunan] = 1;
    }
    $rules_default = generate_rules($arr, array());

    $rules = array();
    foreach ($rules_default as $key => $val) {
        $rules[$key]['nilai'] =  $rules_saved[$key]['nilai'] ? $rules_saved[$key]['nilai'] : 0;
        foreach ($val as $k => $v) {
            $rules[$key]['item'][$k] = $v;
        }
    }
    //echo '<pre>' . print_r($rules_saved, 1) . '</pre>';
    return $rules;
}

function get_kriteria_ids()
{
    global $db;
    $rows = $db->get_results("SELECT kode_kriteria FROM tb_kriteria");
    $data = array();
    foreach ($rows as $row) {
        $data[] = $row->kode_kriteria;
    }
    return $data;
}

function aturan(&$data)
{
}
