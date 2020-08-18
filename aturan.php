<div class="page-header">
    <h1>Aturan</h1>
</div>
<?php
if ($_POST) {
    save_rules($_POST['nilai']);
    print_msg('Data tersimpan', 'success');
}

$rules = get_rules();

//echo '<pre>' . print_r($rules, 1) . '</pre>';

?>
<form action="?m=aturan" method="post">
    <div class="form-group">
        <button class="btn btn-primary">Simpan Nilai</button>
    </div>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>No</th>
                <?php foreach ($KRITERIA as $key => $val) : ?>
                    <th><?= $val->nama_kriteria ?></th>
                <?php endforeach ?>
                <th>Nilai</th>
            </tr>
        </thead>
        <?php foreach ($rules as $key => $val) : ?>
            <tr>
                <td><?= $key + 1 ?></td>
                <?php foreach ($val['item'] as $k => $v) : ?>
                    <td><?= $HIMPUNAN[$v]->nama_himpunan ?></td>
                <?php endforeach ?>
                <td><input class="form-control aw input-sm" type="text" name="nilai[<?= $key ?>]" value="<?= $val['nilai']; //round($key * (30/count($rules)) + 60)-($v=='C02-01' ? 3 :($v=='C02-02' ? 6 :($v=='C02-03' ? 9 : 12)));//
                                                                                                        ?>" /></a></td>
            </tr>
        <?php endforeach ?>
    </table>
    <button class="btn btn-primary">Simpan Nilai</button>
</form>