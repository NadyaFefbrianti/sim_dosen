<?php
// GET /api/index.php -> dokumentasi singkat endpoint (publik)
require_once __DIR__ . '/../includes/api_auth.php';
json_out([
    'nama'      => 'API SIM Dosen UM Bengkulu',
    'versi'     => '1.0',
    'autentikasi' => 'POST /api/login.php lalu kirim header "Authorization: Bearer <token>"',
    'endpoint'  => [
        'POST /api/login.php'    => 'Login, dapat token (8 jam)',
        'POST /api/logout.php'   => 'Cabut token',
        'GET|POST|PUT|DELETE /api/dosen.php'  => 'CRUD dosen (?id=, filter: q, prodi_id, status_aktivitas_id, pendidikan_id, status_serdos, page, per_page)',
        'GET|POST|PUT|DELETE /api/master.php' => 'CRUD tabel master (?t=nama_tabel&id=)',
        'GET /api/stats.php'     => 'Statistik ringkas',
    ],
    'hak_akses' => ['admin' => 'semua', 'operator' => 'baca + tulis dosen & master', 'viewer' => 'hanya baca'],
]);
