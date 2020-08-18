<style>
    .text-primary {
        font-weight: bold;
    }
</style>
<div class="page-header">
    <h1>Perhitungan</h1>
</div>
<?php

if (!$ALTERNATIF || !$KRITERIA) :
    echo "Tampaknya anda belum mengatur alternatif dan kriteria. Silahkan tambahkan minimal 3 alternatif dan 3 kriteria.";
else :
    include 'hitung_hasil.php';
endif;
