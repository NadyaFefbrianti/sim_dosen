<?php
// REST API dosen
//   GET    /api/dosen.php            daftar (q, prodi_id, status_aktivitas_id, pendidikan_id, status_serdos, page, per_page)
//   GET    /api/dosen.php?id=1       satu dosen
//   POST   /api/dosen.php            tambah   (JSON)
//   PUT    /api/dosen.php?id=1       ubah     (JSON, boleh sebagian field)
//   DELETE /api/dosen.php?id=1       hapus
require_once __DIR__ . '/../includes/api_auth.php';
require_once __DIR__ . '/../includes/dosen_model.php';

$method = api_method();
$id = (int)($_GET['id'] ?? 0);

switch ($method) {
    case 'GET':
        api_require('dosen.read');
        if ($id) {
            $r = dosen_find($id);
            if (!$r) json_out(['error' => 'Dosen tidak ditemukan.'], 404);
            json_out(['data' => $r]);
        }
        $f = dosen_filters($_GET);
        $perPage = min(100, max(1, (int)($_GET['per_page'] ?? 10)));
        $total = dosen_count($f);
        $pages = max(1, (int)ceil($total / $perPage));
        $page = min(max(1, (int)($_GET['page'] ?? 1)), $pages);
        json_out([
            'data' => dosen_list($f, $perPage, ($page - 1) * $perPage),
            'meta' => ['page' => $page, 'per_page' => $perPage, 'total' => $total, 'total_pages' => $pages],
        ]);

    case 'POST':
        api_require('dosen.write');
        [$err, $clean] = dosen_validate(api_input());
        if ($err) json_out(['error' => 'Validasi gagal.', 'details' => $err], 422);
        $newId = dosen_create($clean);
        json_out(['message' => 'Dosen ditambahkan.', 'data' => dosen_find($newId)], 201);

    case 'PUT':
    case 'PATCH':
        api_require('dosen.write');
        if (!$id) json_out(['error' => 'Parameter id wajib.'], 400);
        $old = dosen_raw($id);
        if (!$old) json_out(['error' => 'Dosen tidak ditemukan.'], 404);
        [$err, $clean] = dosen_validate(array_merge($old, api_input()), $id);
        if ($err) json_out(['error' => 'Validasi gagal.', 'details' => $err], 422);
        dosen_update($id, $clean);
        json_out(['message' => 'Dosen diperbarui.', 'data' => dosen_find($id)]);

    case 'DELETE':
        api_require('dosen.write');
        if (!$id) json_out(['error' => 'Parameter id wajib.'], 400);
        if (!dosen_raw($id)) json_out(['error' => 'Dosen tidak ditemukan.'], 404);
        dosen_delete($id);
        json_out(['message' => 'Dosen dihapus.']);

    default:
        json_out(['error' => 'Metode tidak didukung.'], 405);
}
