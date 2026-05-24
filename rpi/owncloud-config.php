<?php
$CONFIG = array (
  'instanceid' => 'ocmxltqhktqj',
  'passwordsalt' => 'REPLACE_WITH_SALT',
  'secret' => 'REPLACE_WITH_SECRET',
  'trusted_domains' => 
  array (
    0 => '192.168.1.104',
     1 => 'YOUR_PUBLIC_IP',
    2 => 'rpi',
    3 => '192.168.1.76',
    4 => 'raspberrypi.local'
  ),
  'datadirectory' => '/media/pi/Touro/nextcloud/',
  'overwrite.cli.url' => 'http://192.168.1.104/nextcloud',
  'dbtype' => 'mysql',
  'version' => '13.0.5.2',
  'dbname' => 'nextcloud',
  'dbhost' => 'localhost',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'dbuser' => 'YOUR_DB_USER',
  'dbpassword' => 'YOUR_DB_PASSWORD',
  'installed' => true,
  'filelocking.enabled' => false,

);

