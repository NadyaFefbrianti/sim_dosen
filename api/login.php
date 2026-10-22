<?php
// POST /api/login.php  body JSON: {"username":"...","password":"..."}  -> token Bearer (berlaku 8 jam)
require_once __DIR__ . '/../includes/api_auth.php';
if (api_method() !== 'POST') json_out(['error' => 'Gunakan metode POST.'], 405);

$in = api_input();
$username = trim((string)($in['username'] ?? ''));
$password = (string)($in['password'] ?? '');

$st = db()->prepare('SELECT id, username, nama_lengkap, role, password_hash FROM users WHERE username = ? AND is_active = 1');
$st->execute([$username]);
$u = $st->fetch();

if (!$u || !password_verify($password, $u['password_hash'])) {
    usleep(400000); // perlambat tebak-tebakan password
    json_out(['error' => 'Username atau password salah.'], 401);
}

db()->exec('DELETE FROM api_tokens WHERE expires_at < NOW()');
$token = bin2hex(random_bytes(32));
db()->prepare('INSERT INTO api_tokens (user_id, token_hash, expires_at) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 8 HOUR))')
    ->execute([$u['id'], hash('sha256', $token)]);

json_out([
    'token'      => $token,
    'token_type' => 'Bearer',
    'expires_in' => 28800,
    'user'       => ['id' => (int)$u['id'], 'username' => $u['username'], 'nama_lengkap' => $u['nama_lengkap'], 'role' => $u['role']],
]);
