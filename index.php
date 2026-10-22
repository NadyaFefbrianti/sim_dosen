<?php
// index.php - Landing page (publik)
require_once __DIR__ . '/includes/auth.php';
$u = current_user();
$stats = stats_summary();
$preview = dosen_preview();

function dosen_preview(): array
{
    return db()->query('SELECT d.nama, jf.nama AS jabatan, pd.nama AS pend, sa.nama AS aktif, d.status_serdos
                        FROM dosen d
                        LEFT JOIN jabatan_fungsional jf ON jf.id = d.jabatan_fungsional_id
                        LEFT JOIN pendidikan pd ON pd.id = d.pendidikan_id
                        LEFT JOIN status_aktivitas sa ON sa.id = d.status_aktivitas_id
                        ORDER BY d.id DESC LIMIT 5')->fetchAll();
}
?><!DOCTYPE html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e(APP_NAME) ?></title>
<link rel="stylesheet" href="assets/style.css">
</head>
<body>
<section class="hero">
  <div class="container">
    <div>
      <h1>Data dosen Universitas Muhammadiyah Bengkulu, rapi dalam satu sistem.</h1>
      <p>Catat nomor registrasi, NUPTK, jabatan fungsional, status sertifikasi, sampai penempatan dosen. Cetak daftar dosen aktif per program studi kapan saja.</p>
      <div class="cta">
        <?php if ($u): ?>
          <a class="btn btn-gold" href="dashboard.php">Buka dashboard</a>
        <?php else: ?>
          <a class="btn btn-gold" href="login.php">Masuk ke sistem</a>
        <?php endif; ?>
        <a class="btn btn-ghost" href="api/index.php">Lihat dokumentasi API</a>
      </div>
    </div>
    <div class="sheet" aria-label="Contoh daftar dosen">
      <h3>Daftar Dosen Aktif Universitas</h3>
      <div class="meta">Universitas Muhammadiyah Bengkulu &middot; Fakultas Teknik</div>
      <div class="tablewrap">
      <table>
        <thead><tr><th>Nama</th><th>Jabatan</th><th>Pend.</th><th>Aktivitas</th><th>Serdos</th></tr></thead>
        <tbody>
        <?php foreach ($preview as $r): ?>
          <tr><td><?= e($r['nama']) ?></td><td><?= e($r['jabatan'] ?? '-') ?></td><td><?= e($r['pend'] ?? '-') ?></td>
              <td><?= e($r['aktif'] ?? '-') ?></td><td><?= e($r['status_serdos']) ?></td></tr>
        <?php endforeach; ?>
        <?php if (!$preview): ?><tr><td colspan="5" class="muted">Belum ada data dosen.</td></tr><?php endif; ?>
        </tbody>
      </table>
      </div>
    </div>
  </div>
</section>

<div class="container">
  <div class="grid g4">
    <div class="card stat"><b><?= (int)$stats['total_dosen'] ?></b><span>dosen tercatat</span></div>
    <div class="card stat"><b><?= (int)$stats['dosen_aktif'] ?></b><span>berstatus aktif</span></div>
    <div class="card stat"><b><?= (int)$stats['sudah_serdos'] ?></b><span>sudah sertifikasi dosen</span></div>
    <div class="card stat"><b><?= (int)$stats['total_prodi'] ?></b><span>program studi terdaftar</span></div>
  </div>

  <div class="features">
    <div class="card"><h3>Kelola data</h3><p>Tambah, ubah, dan hapus data dosen serta tabel pendukung seperti jabatan, kepangkatan, dan program studi.</p></div>
    <div class="card"><h3>Hak akses per peran</h3><p>Admin, operator, dan viewer punya batas akses yang berbeda, sehingga data tidak diubah sembarang orang.</p></div>
    <div class="card"><h3>Laporan siap cetak</h3><p>Filter berdasarkan program studi atau status, lalu cetak atau unduh sebagai CSV untuk Excel.</p></div>
    <div class="card"><h3>Web service (API)</h3><p>Aplikasi lain bisa membaca dan mengelola data dosen lewat REST API berformat JSON dengan token.</p></div>
  </div>
  <p class="foot">&copy; <?= date('Y') ?> <?= e(APP_NAME) ?></p>
</div>
</body>
</html>
