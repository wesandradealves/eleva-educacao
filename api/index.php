<?php 
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

    require "./bootstrap.php";
    use Src\Controller\PersonController;

    $id = null;
    $table = null;

    if(strrpos($_SERVER['REQUEST_URI'], "&") > 0) {
        $uri = explode( '&', $_SERVER['REQUEST_URI'] );

        if (isset($uri[0])) {
            $id = (int) explode('=', $uri[0])[1];
        }

        if (isset($uri[1])) {
            $table = explode('=', $uri[1])[1];
        }   
    } else {
        if(strrpos($_SERVER['REQUEST_URI'], "=") > 0) {
            $uri = explode( '=', $_SERVER['REQUEST_URI'] );

            if(strLen($uri[1]) === 1) {
                $id = $uri[1];
                $table = null;
            } else {
                $table = $uri[1];
                $id = null;
            }
        }
    }

    $requestMethod = $_SERVER["REQUEST_METHOD"];

    if($requestMethod !== 'DELETE') {
        if(!sizeof($_REQUEST)) {
            print 'Api Works!';
        } else {
            $controller = new PersonController($dbConnection, $requestMethod, $id, $table);
            $controller->processRequest();        
        }
    } else {
        $controller = new PersonController($dbConnection, $requestMethod, $id, $table);
        $controller->processRequest();    
    }
