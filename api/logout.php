<?php
// POST /api/logout.php  -> mencabut token yang sedang dipakai
require_once __DIR__ . '/../includes/api_auth.php';
if (api_method() !== 'POST') json_out(['error' => 'Gunakan metode POST.'], 405);
api_user();
db()->prepare('DELETE FROM api_tokens WHERE token_hash = ?')->execute([hash('sha256', bearer_token())]);
json_out(['message' => 'Token dicabut.']);
