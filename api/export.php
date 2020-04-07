<?php 
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


    $host = "52.31.153.88";
    $user = "pgrtrainee";
    $pass = "yu1lGev2bopU";
    $db = "lasa_programa_trainee";
	$charset = 'utf8mb4';

	$options = [
	    \PDO::ATTR_ERRMODE            => \PDO::ERRMODE_EXCEPTION,
	    \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
	    \PDO::ATTR_EMULATE_PREPARES   => false,
	];
	$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

	try {
	    $pdo = new \PDO($dsn, $user, $pass, $options);
	    $stmt = $pdo->query("SELECT * FROM avaliacoes");

	    $avaliacoes = $stmt->fetchAll();

	    foreach ($avaliacoes as $key => $value) {
			$cURLConnection = curl_init();

			curl_setopt($cURLConnection, CURLOPT_URL, 'http://programatraineeapi/?id='.$value['candidateId'].'&env=candidatos');
			curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, true);

			$user = curl_exec($cURLConnection);
			curl_close($cURLConnection);

			print_r($value);
			print_r(json_decode($user));
			echo '========================================';	    	
	    }
	} catch (\PDOException $e) {
	     throw new \PDOException($e->getMessage(), (int)$e->getCode());
	}    