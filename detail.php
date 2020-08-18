<div class="col-md-8">
    <?php
    $row = $db->get_row("SELECT * FROM tb_alternatif WHERE kode_alternatif='$_GET[ID]'");
    ?>
    <div class="page-header">
        <h1><?= $row->nama_alternatif ?></h1>

    </div>
    <img class="img-thumbnail" src="gambar/<?= $row->gambar ?>" />
    <div>
        <?= $row->keterangan ?>
    </div>
</div>
<div class="col-md-4">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Data Alternatif</h3>
        </div>
        <ul class="list-group">
            <?php
            $rows = $db->get_results("SELECT * FROM tb_alternatif WHERE kode_alternatif<>'$_GET[ID]' ORDER BY kode_alternatif");
            foreach ($rows as $row) : ?>
                <li class="list-group-item"><a href="?m=detail&ID=<?= $row->kode_alternatif ?>"><?= $row->nama_alternatif ?></a></li>
            <?php endforeach ?>
        </ul>
    </div>
</div>