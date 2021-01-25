<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'admin' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql-service' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'IZp8N9m[}8{fY-<vWi)b5h765iseqR~t)A=^R<`7WtE%0>nzazBhZQz7WAl$O,0<' );
define( 'SECURE_AUTH_KEY',  '4AvQ)r^b?2p?Pj$NT}S@R{UhM[Z@,u>:U%a}YoIp.Uv_/AHjA$i,[hL{W$U?!aZP' );
define( 'LOGGED_IN_KEY',    '=aUXW%7uOF[zOQ?2F2tIH<P.otGU(KST3rtY`JJ~P2-HC;9wF.}YzO9`b6)by.j{' );
define( 'NONCE_KEY',        '=zQ#Ahkwg{l#`Lh }~9g_=80K(Z*nohm[!?8X}Yt`4C9gh@+ze%;Jn*-Y1$gppf8' );
define( 'AUTH_SALT',        'L?=>yrH:o66u>{Eda B;_H|mGYbtjPCb>wo`w$;sA,Xy+qG<zsF*V$_rL,^%):n?' );
define( 'SECURE_AUTH_SALT', 'k_+20@yis%0g?qL (h^:%gb8r<4;K|?-Fiv@.ueY5owg+Y_YiT=|LUjLb 15BIBH' );
define( 'LOGGED_IN_SALT',   '@tP3V1NoZAA(GD>o{%JZ).P1NB`iIl%eU#$FfuCt-WX3hhSZN@t?^[>L16+VKqwA' );
define( 'NONCE_SALT',       '_krQ}C(bT(BjvI4{=k2b)|X*1:RR%;^q_m@M2xh[/?*?H2)SXE!fzkAX{__;LN@e' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define('CONCATENATE_SCRIPTS', false);
define( ‘SCRIPT_DEBUG’, true );
define( 'WP_DEBUG', false );

if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') $_SERVER['HTTPS']='on';

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';