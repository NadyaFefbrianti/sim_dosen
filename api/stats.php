<?php
// GET /api/stats.php -> ringkasan statistik dosen
require_once __DIR__ . '/../includes/api_auth.php';
if (api_method() !== 'GET') json_out(['error' => 'Gunakan metode GET.'], 405);
api_require('dosen.read');
json_out([
    'ringkasan'          => stats_summary(),
    'per_jabatan'        => stats_group('jabatan_fungsional', 'jabatan_fungsional_id'),
    'per_pendidikan'     => stats_group('pendidikan', 'pendidikan_id'),
    'per_status_aktivitas' => stats_group('status_aktivitas', 'status_aktivitas_id'),
]);
