-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Okt 2026 pada 16.08
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simdosen`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `api_tokens`
--

CREATE TABLE `api_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `id` int(10) UNSIGNED NOT NULL,
  `nomor_registrasi` varchar(30) NOT NULL,
  `nuptk` char(16) DEFAULT NULL,
  `nama` varchar(150) NOT NULL,
  `nip` varchar(18) DEFAULT NULL,
  `jabatan_fungsional_id` int(10) UNSIGNED DEFAULT NULL,
  `kepangkatan_id` int(10) UNSIGNED DEFAULT NULL,
  `pendidikan_id` int(10) UNSIGNED DEFAULT NULL,
  `rumpun_ilmu_id` int(10) UNSIGNED DEFAULT NULL,
  `status_serdos` enum('Sudah','Belum') NOT NULL DEFAULT 'Belum',
  `status_pegawai_id` int(10) UNSIGNED DEFAULT NULL,
  `ikatan_kerja_id` int(10) UNSIGNED DEFAULT NULL,
  `status_aktivitas_id` int(10) UNSIGNED DEFAULT NULL,
  `prodi_id` int(10) UNSIGNED DEFAULT NULL,
  `penempatan` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`id`, `nomor_registrasi`, `nuptk`, `nama`, `nip`, `jabatan_fungsional_id`, `kepangkatan_id`, `pendidikan_id`, `rumpun_ilmu_id`, `status_serdos`, `status_pegawai_id`, `ikatan_kerja_id`, `status_aktivitas_id`, `prodi_id`, `penempatan`, `created_at`, `updated_at`) VALUES
(1, 'REG-0001', '1234567890123401', 'Dosen Contoh Satu, M.Kom.', NULL, 3, 3, 2, 1, 'Sudah', 1, 1, 1, 1, 'Universitas Muhammadiyah Bengkulu', '2026-10-22 08:30:49', '2026-10-22 08:30:49'),
(2, 'REG-0002', '1234567890123402', 'Dosen Contoh Dua, M.T.', '198001012005011001', 4, 5, 3, 1, 'Sudah', 3, 1, 1, 1, 'Universitas Muhammadiyah Bengkulu', '2026-10-22 08:30:49', '2026-10-22 08:30:49'),
(3, 'REG-0003', '1234567890123403', 'Dosen Contoh Tiga, M.Cs.', NULL, 2, 2, 2, 5, 'Belum', 1, 1, 1, 1, 'Universitas Muhammadiyah Bengkulu', '2026-10-22 08:30:49', '2026-10-22 08:30:49'),
(4, 'REG-0004', NULL, 'Dosen Contoh Empat, S.T., M.T.', NULL, 1, NULL, 2, 2, 'Belum', 2, 2, 3, 2, 'Universitas Muhammadiyah Bengkulu', '2026-10-22 08:30:49', '2026-10-22 08:30:49'),
(5, 'REG-0005', '1234567890123405', 'Dosen Contoh Lima, Ph.D.', NULL, 3, 4, 3, 3, 'Sudah', 1, 1, 2, 3, 'Universitas Muhammadiyah Bengkulu', '2026-10-22 08:30:49', '2026-10-22 08:30:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `fakultas`
--

CREATE TABLE `fakultas` (
  `id` int(10) UNSIGNED NOT NULL,
  `universitas_id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `fakultas`
--

INSERT INTO `fakultas` (`id`, `universitas_id`, `nama`) VALUES
(1, 1, 'Teknik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `ikatan_kerja`
--

CREATE TABLE `ikatan_kerja` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `ikatan_kerja`
--

INSERT INTO `ikatan_kerja` (`id`, `nama`) VALUES
(3, 'Dosen LB'),
(1, 'Dosen Tetap'),
(2, 'Dosen Tidak Tetap');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jabatan_fungsional`
--

CREATE TABLE `jabatan_fungsional` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jabatan_fungsional`
--

INSERT INTO `jabatan_fungsional` (`id`, `nama`) VALUES
(2, 'Asisten Ahli'),
(5, 'Guru Besar'),
(3, 'Lektor'),
(4, 'Lektor Kepala'),
(1, 'Tenaga Pengajar');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kepangkatan`
--

CREATE TABLE `kepangkatan` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kepangkatan`
--

INSERT INTO `kepangkatan` (`id`, `nama`) VALUES
(5, 'Pembina (IV/a)'),
(6, 'Pembina Tk.I (IV/b)'),
(7, 'Pembina Utama Muda (IV/c)'),
(3, 'Penata (III/c)'),
(1, 'Penata Muda (III/a)'),
(2, 'Penata Muda Tk.I (III/b)'),
(4, 'Penata Tk.I (III/d)');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendidikan`
--

CREATE TABLE `pendidikan` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pendidikan`
--

INSERT INTO `pendidikan` (`id`, `nama`) VALUES
(4, 'Profesi'),
(1, 'S1'),
(2, 'S2'),
(3, 'S3');

-- --------------------------------------------------------

--
-- Struktur dari tabel `program_studi`
--

CREATE TABLE `program_studi` (
  `id` int(10) UNSIGNED NOT NULL,
  `fakultas_id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `program_studi`
--

INSERT INTO `program_studi` (`id`, `fakultas_id`, `nama`) VALUES
(3, 1, 'Teknik Elektro'),
(1, 1, 'Teknik Informatika'),
(4, 1, 'Teknik Mesin'),
(2, 1, 'Teknik Sipil');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rumpun_ilmu`
--

CREATE TABLE `rumpun_ilmu` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `rumpun_ilmu`
--

INSERT INTO `rumpun_ilmu` (`id`, `nama`) VALUES
(1, 'Ilmu Komputer'),
(5, 'Sistem Informasi'),
(3, 'Teknik Elektro'),
(4, 'Teknik Mesin'),
(2, 'Teknik Sipil');

-- --------------------------------------------------------

--
-- Struktur dari tabel `status_aktivitas`
--

CREATE TABLE `status_aktivitas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `status_aktivitas`
--

INSERT INTO `status_aktivitas` (`id`, `nama`) VALUES
(1, 'Aktif'),
(3, 'Cuti'),
(4, 'Izin Belajar'),
(5, 'Pensiun'),
(2, 'Tugas Belajar');

-- --------------------------------------------------------

--
-- Struktur dari tabel `status_pegawai`
--

CREATE TABLE `status_pegawai` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `status_pegawai`
--

INSERT INTO `status_pegawai` (`id`, `nama`) VALUES
(1, 'Dosen Tetap Yayasan'),
(2, 'Dosen Tidak Tetap'),
(3, 'PNS DPK');

-- --------------------------------------------------------

--
-- Struktur dari tabel `universitas`
--

CREATE TABLE `universitas` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `universitas`
--

INSERT INTO `universitas` (`id`, `nama`) VALUES
(1, 'Universitas Muhammadiyah Bengkulu');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `role` enum('admin','operator','viewer') NOT NULL DEFAULT 'viewer',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `nama_lengkap`, `role`, `is_active`, `created_at`) VALUES
(1, 'admin', '$2y$10$sr3WNxpGHnTE.JCfAfHzFeLZ3Ys.jZhi9im7CpE4iTx1/565rLZbK', 'Admin SIMDOSEN', 'admin', 1, '2026-10-22 11:47:00'),
(3, 'viewer', '$2y$10$m.6lNjr9rBsMGUiPUDojae3phhZMXNX5wd7tdxymnDpLGVFUQA4CW', 'nadyaa', 'viewer', 1, '2026-10-22 12:17:27'),
(4, 'operator', '$2y$10$0Esnum3aIxeNyPI4NuG2tOLw2ZPVQGHkryfTXsGIgsYoQPhm6ot.2', 'nana', 'operator', 1, '2026-10-22 12:19:03');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `fk_token_user` (`user_id`);

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_registrasi` (`nomor_registrasi`),
  ADD UNIQUE KEY `nuptk` (`nuptk`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `idx_dosen_nama` (`nama`),
  ADD KEY `fk_d_jabatan` (`jabatan_fungsional_id`),
  ADD KEY `fk_d_pangkat` (`kepangkatan_id`),
  ADD KEY `fk_d_pend` (`pendidikan_id`),
  ADD KEY `fk_d_rumpun` (`rumpun_ilmu_id`),
  ADD KEY `fk_d_spegawai` (`status_pegawai_id`),
  ADD KEY `fk_d_ikatan` (`ikatan_kerja_id`),
  ADD KEY `fk_d_aktif` (`status_aktivitas_id`),
  ADD KEY `fk_d_prodi` (`prodi_id`);

--
-- Indeks untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_fakultas` (`universitas_id`,`nama`);

--
-- Indeks untuk tabel `ikatan_kerja`
--
ALTER TABLE `ikatan_kerja`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `jabatan_fungsional`
--
ALTER TABLE `jabatan_fungsional`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `kepangkatan`
--
ALTER TABLE `kepangkatan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `pendidikan`
--
ALTER TABLE `pendidikan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `program_studi`
--
ALTER TABLE `program_studi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_prodi` (`fakultas_id`,`nama`);

--
-- Indeks untuk tabel `rumpun_ilmu`
--
ALTER TABLE `rumpun_ilmu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `status_aktivitas`
--
ALTER TABLE `status_aktivitas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `status_pegawai`
--
ALTER TABLE `status_pegawai`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `universitas`
--
ALTER TABLE `universitas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama` (`nama`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `api_tokens`
--
ALTER TABLE `api_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `ikatan_kerja`
--
ALTER TABLE `ikatan_kerja`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `jabatan_fungsional`
--
ALTER TABLE `jabatan_fungsional`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `kepangkatan`
--
ALTER TABLE `kepangkatan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `pendidikan`
--
ALTER TABLE `pendidikan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `program_studi`
--
ALTER TABLE `program_studi`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `rumpun_ilmu`
--
ALTER TABLE `rumpun_ilmu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `status_aktivitas`
--
ALTER TABLE `status_aktivitas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `status_pegawai`
--
ALTER TABLE `status_pegawai`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `universitas`
--
ALTER TABLE `universitas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD CONSTRAINT `fk_token_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `fk_d_aktif` FOREIGN KEY (`status_aktivitas_id`) REFERENCES `status_aktivitas` (`id`),
  ADD CONSTRAINT `fk_d_ikatan` FOREIGN KEY (`ikatan_kerja_id`) REFERENCES `ikatan_kerja` (`id`),
  ADD CONSTRAINT `fk_d_jabatan` FOREIGN KEY (`jabatan_fungsional_id`) REFERENCES `jabatan_fungsional` (`id`),
  ADD CONSTRAINT `fk_d_pangkat` FOREIGN KEY (`kepangkatan_id`) REFERENCES `kepangkatan` (`id`),
  ADD CONSTRAINT `fk_d_pend` FOREIGN KEY (`pendidikan_id`) REFERENCES `pendidikan` (`id`),
  ADD CONSTRAINT `fk_d_prodi` FOREIGN KEY (`prodi_id`) REFERENCES `program_studi` (`id`),
  ADD CONSTRAINT `fk_d_rumpun` FOREIGN KEY (`rumpun_ilmu_id`) REFERENCES `rumpun_ilmu` (`id`),
  ADD CONSTRAINT `fk_d_spegawai` FOREIGN KEY (`status_pegawai_id`) REFERENCES `status_pegawai` (`id`);

--
-- Ketidakleluasaan untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  ADD CONSTRAINT `fk_fakultas_univ` FOREIGN KEY (`universitas_id`) REFERENCES `universitas` (`id`);

--
-- Ketidakleluasaan untuk tabel `program_studi`
--
ALTER TABLE `program_studi`
  ADD CONSTRAINT `fk_prodi_fakultas` FOREIGN KEY (`fakultas_id`) REFERENCES `fakultas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
