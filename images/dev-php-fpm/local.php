<?php

declare(strict_types=1);

$_SERVER['VAR_DUMPER_SERVER'] = 'host.docker.internal:9912';
if (!\function_exists('dumps')) {
  function dumps(mixed $var): void {
    $prev_var_dumper_format = $_SERVER['VAR_DUMPER_FORMAT'] ?? NULL;
    $_SERVER['VAR_DUMPER_FORMAT'] = 'server';
    \Symfony\Component\VarDumper\VarDumper::dump($var);
    $_SERVER['VAR_DUMPER_FORMAT'] = $prev_var_dumper_format;
  }
}
