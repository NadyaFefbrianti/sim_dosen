<?php
// ============================================================
// koneksi.php - konfigurasi database (sesuaikan dengan XAMPP/hosting)
// ============================================================
const DB_HOST = '127.0.0.1';
const DB_PORT = 3306;
const DB_NAME = 'simdosen';
const DB_USER = 'root';   // default XAMPP
const DB_PASS = '';       // default XAMPP kosong
const APP_NAME = 'SIM Dosen UM Bengkulu';

function db(): PDO
{
    static $pdo = null;
    if ($pdo === null) {
        $dsn = 'mysql:host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_NAME . ';charset=utf8mb4';
        try {
            $pdo = new PDO($dsn, DB_USER, DB_PASS, [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]);
        } catch (PDOException $e) {
            error_log('Koneksi DB gagal: ' . $e->getMessage());
            http_response_code(500);
            exit('Koneksi database gagal. Cek pengaturan di koneksi.php dan pastikan MySQL sudah menyala + database simdosen sudah di-import.');
        }
    }
    return $pdo;
}
