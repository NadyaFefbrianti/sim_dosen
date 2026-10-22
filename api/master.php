<?php
// REST API tabel master  (parameter wajib: t = universitas | fakultas | program_studi | jabatan_fungsional |
//                         kepangkatan | pendidikan | rumpun_ilmu | status_pegawai | ikatan_kerja | status_aktivitas)
//   GET    /api/master.php?t=pendidikan            daftar
//   GET    /api/master.php?t=pendidikan&id=1       satu data
//   POST   /api/master.php?t=pendidikan            {"nama":"D3"}  (fakultas/prodi juga butuh "parent_id")
//   PUT    /api/master.php?t=pendidikan&id=1       {"nama":"..."}
//   DELETE /api/master.php?t=pendidikan&id=1
require_once __DIR__ . '/../includes/api_auth.php';
require_once __DIR__ . '/../includes/master_model.php';

$t = (string)($_GET['t'] ?? '');
if (!isset(master_tables()[$t])) {
    json_out(['error' => 'Parameter t tidak valid.', 'tabel_tersedia' => array_keys(master_tables())], 400);
}
$id = (int)($_GET['id'] ?? 0);

switch (api_method()) {
    case 'GET':
        api_require('master.read');
        if ($id) {
            $r = master_find($t, $id);
            if (!$r) json_out(['error' => 'Data tidak ditemukan.'], 404);
            json_out(['data' => $r]);
        }
        json_out(['data' => master_list($t)]);

    case 'POST':
        api_require('master.write');
        [$err, $clean] = master_validate($t, api_input(), null);
        if ($err) json_out(['error' => 'Validasi gagal.', 'details' => $err], 422);
        $newId = master_save($t, null, $clean);
        json_out(['message' => 'Data ditambahkan.', 'data' => master_find($t, $newId)], 201);

    case 'PUT':
    case 'PATCH':
        api_require('master.write');
        if (!$id) json_out(['error' => 'Parameter id wajib.'], 400);
        $old = master_find($t, $id);
        if (!$old) json_out(['error' => 'Data tidak ditemukan.'], 404);
        [$err, $clean] = master_validate($t, array_merge($old, api_input()), $id);
        if ($err) json_out(['error' => 'Validasi gagal.', 'details' => $err], 422);
        master_save($t, $id, $clean);
        json_out(['message' => 'Data diperbarui.', 'data' => master_find($t, $id)]);

    case 'DELETE':
        api_require('master.write');
        if (!$id) json_out(['error' => 'Parameter id wajib.'], 400);
        if (!master_find($t, $id)) json_out(['error' => 'Data tidak ditemukan.'], 404);
        $msg = master_delete($t, $id);
        if ($msg) json_out(['error' => $msg], 409);
        json_out(['message' => 'Data dihapus.']);

    default:
        json_out(['error' => 'Metode tidak didukung.'], 405);
}
