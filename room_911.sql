-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-09-2024 a las 14:44:28
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `room_911`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `access_attempts`
--

CREATE TABLE `access_attempts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `was_successful` tinyint(1) NOT NULL,
  `result_message` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `access_attempts`
--

INSERT INTO `access_attempts` (`id`, `employee_id`, `was_successful`, `result_message`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Access granted', '2024-09-13 07:05:52', '2024-09-13 07:05:52'),
(2, 2, 0, 'Room access is not allowed', '2024-09-13 16:35:28', '2024-09-13 16:35:28'),
(3, 2, 0, 'Room access is not allowed', '2024-09-13 16:43:03', '2024-09-13 16:43:03'),
(4, 2, 0, 'Room access is not allowed', '2024-09-13 16:45:46', '2024-09-13 16:45:46'),
(5, 2, 0, 'Room access is not allowed', '2024-09-13 16:45:56', '2024-09-13 16:45:56'),
(6, 2, 0, 'Room access is not allowed', '2024-09-13 16:46:07', '2024-09-13 16:46:07'),
(7, 2, 0, 'Room access is not allowed', '2024-09-13 16:50:09', '2024-09-13 16:50:09'),
(8, 5, 0, 'Room access is not allowed', '2024-09-13 16:50:42', '2024-09-13 16:50:42'),
(9, 5, 0, 'Room access is not allowed', '2024-09-13 16:50:59', '2024-09-13 16:50:59'),
(10, 6, 1, 'Access granted', '2024-09-13 16:51:53', '2024-09-13 16:51:53'),
(11, 6, 1, 'Access granted', '2024-09-13 16:52:09', '2024-09-13 16:52:09'),
(12, 6, 1, 'Access granted', '2024-09-13 16:52:59', '2024-09-13 16:52:59'),
(13, 6, 1, 'Access granted', '2024-09-13 16:55:50', '2024-09-13 16:55:50'),
(14, 6, 1, 'Access granted', '2024-09-13 16:55:59', '2024-09-13 16:55:59'),
(15, 6, 1, 'Access granted', '2024-09-13 16:57:06', '2024-09-13 16:57:06'),
(16, 6, 1, 'Access granted', '2024-09-13 16:57:30', '2024-09-13 16:57:30'),
(17, 6, 1, 'Access granted', '2024-09-13 16:58:53', '2024-09-13 16:58:53'),
(18, 6, 1, 'Access granted', '2024-09-13 17:37:51', '2024-09-13 17:37:51'),
(19, 6, 1, 'Access granted', '2024-09-13 17:38:31', '2024-09-13 17:38:31'),
(20, 6, 1, 'Access granted', '2024-09-13 17:41:45', '2024-09-13 17:41:45'),
(21, 6, 1, 'Access granted', '2024-09-13 17:41:49', '2024-09-13 17:41:49'),
(22, 6, 1, 'Access granted', '2024-09-13 17:41:50', '2024-09-13 17:41:50'),
(23, 6, 1, 'Access granted', '2024-09-13 17:42:22', '2024-09-13 17:42:22'),
(24, 6, 1, 'Access granted', '2024-09-13 17:42:45', '2024-09-13 17:42:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Human Resources', NULL, NULL),
(2, 'Patient Services', NULL, NULL),
(3, 'Administration', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `internal_id` varchar(255) NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `room_access` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `first_name`, `last_name`, `internal_id`, `department_id`, `room_access`, `created_at`, `updated_at`) VALUES
(2, 'jorge', 'name 11', 'Id11111111111112', 1, 0, '2024-09-13 00:55:12', '2024-09-13 13:11:49'),
(5, 'anan', 'name 2', '123413131', 1, 0, '2024-09-13 00:54:37', '2024-09-13 12:59:31'),
(6, 'name  1', 'name 2', '123413131A', 1, 1, '2024-09-13 00:55:12', '2024-09-13 00:55:12'),
(7, 'Juan', 'Pérez', 'EMP001234', 1, 1, '2024-09-13 15:42:27', '2024-09-13 15:42:27'),
(8, 'María', 'Gómez', 'EMP001235', 2, 0, '2024-09-13 15:42:27', '2024-09-13 15:42:27'),
(9, 'Carlos', 'Ramírez', 'EMP001236', 3, 1, '2024-09-13 15:42:27', '2024-09-13 15:42:27'),
(11, 'Ana', 'Morales', 'EMP001237', 1, 1, '2024-09-13 15:44:19', '2024-09-13 15:44:19'),
(12, 'Luis', 'Garcia', 'EMP001238', 2, 0, '2024-09-13 15:44:19', '2024-09-13 15:44:19'),
(13, 'Maria', 'Lopez', 'EMP001239', 3, 1, '2024-09-13 15:44:19', '2024-09-13 15:44:19'),
(14, 'Carlos', 'Herrera', 'EMP001240', 1, 0, '2024-09-13 15:44:19', '2024-09-13 15:44:19'),
(15, 'Isabel', 'Rodriguez', 'EMP001241', 2, 1, '2024-09-13 15:44:19', '2024-09-13 15:44:19'),
(16, 'Jorge', 'Perez', 'EMP001242', 3, 0, '2024-09-13 15:44:19', '2024-09-13 15:44:19'),
(17, 'Patricia', 'Martinez', 'EMP001243', 1, 1, '2024-09-13 15:44:20', '2024-09-13 15:44:20'),
(18, 'Fernando', 'Jimenez', 'EMP001244', 2, 0, '2024-09-13 15:44:20', '2024-09-13 15:44:20'),
(19, 'Laura', 'Castro', 'EMP001245', 3, 1, '2024-09-13 15:44:20', '2024-09-13 15:44:20'),
(20, 'Andres', 'Muñoz', 'EMP001246', 1, 0, '2024-09-13 15:44:20', '2024-09-13 15:44:20'),
(22, 'marlon', 'adada', '13123131312312', 1, 1, '2024-09-13 16:00:32', '2024-09-13 16:00:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_09_12_031947_create_departments_table', 1),
(6, '2024_09_12_032712_create_employees_table', 1),
(7, '2024_09_12_041809_create_permission_tables', 1),
(8, '2024_09_12_042424_create_access_attempts_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin_room_911', 'web', '2024-09-13 00:53:23', '2024-09-13 00:53:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'edinson balaguera', 'edinsonbala@gmail.com', NULL, '$2y$12$h/Xc0bdCL9vUijmp1nTtk.dBvY0b54kGW9NjC6trJXIg/l7g.IhnG', NULL, '2024-09-13 00:54:18', '2024-09-13 00:54:18');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `access_attempts`
--
ALTER TABLE `access_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `access_attempts_employee_id_foreign` (`employee_id`);

--
-- Indices de la tabla `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `departments_name_unique` (`name`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_internal_id_unique` (`internal_id`),
  ADD KEY `employees_department_id_foreign` (`department_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `access_attempts`
--
ALTER TABLE `access_attempts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `access_attempts`
--
ALTER TABLE `access_attempts`
  ADD CONSTRAINT `access_attempts_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
