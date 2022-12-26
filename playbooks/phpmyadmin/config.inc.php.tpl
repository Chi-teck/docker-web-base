<?php

/**
 * PhpMyadmin configuration.
 */

$i = 0;

$i++;
$cfg['Servers'][$i]['auth_type'] = 'config';
$cfg['Servers'][$i]['user'] = '$USER';
$cfg['Servers'][$i]['password'] = '$PASSWORD';
$cfg['Servers'][$i]['AllowNoPassword'] = TRUE;
$cfg['Servers'][$i]['AllowRoot'] = TRUE;
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['compress'] = false;
$cfg['TempDir'] = '/tmp';
