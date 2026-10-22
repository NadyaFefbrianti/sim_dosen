<?php
// login.php - halaman login
require_once __DIR__ . '/includes/auth.php';

if (current_user()) redirect('dashboard.php');

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_verify();
    $username = trim((string)($_POST['username'] ?? ''));
    $password = (string)($_POST['password'] ?? '');
    $wait = login_locked_seconds();
    if ($wait > 0) {
        $error = 'Terlalu banyak percobaan gagal. Coba lagi dalam ' . ceil($wait / 60) . ' menit.';
    } elseif (login_attempt($username, $password)) {
        redirect('dashboard.php');
    } else {
        $error = login_locked_seconds() > 0
            ? 'Terlalu banyak percobaan gagal. Akun dikunci sementara selama 5 menit.'
            : 'Username atau password salah.';
    }
}
?><!DOCTYPE html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Masuk - <?= e(APP_NAME) ?></title>
<link rel="stylesheet" href="assets/style.css">
</head>
<body class="auth">
<div class="authbox">
  <div class="card">
    <h1>Masuk</h1>
    <p class="muted"><?= e(APP_NAME) ?></p>
    <?= flash_render() ?>
    <?php if ($error): ?><div class="alert alert-error"><?= e($error) ?></div><?php endif; ?>
    <form method="post" autocomplete="off">
      <?= csrf_field() ?>
      <div class="field"><label for="username">Username</label>
        <input type="text" id="username" name="username" value="<?= e($_POST['username'] ?? '') ?>" required autofocus></div>
      <div class="field"><label for="password">Password</label>
        <input type="password" id="password" name="password" required></div>
      <button class="btn" type="submit">Masuk</button>
      <a class="btn btn-line" href="index.php">Kembali</a>
    </form>
  </div>
</div>
</body>
</html>
