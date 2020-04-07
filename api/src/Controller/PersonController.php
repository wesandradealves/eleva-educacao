<?php
namespace Src\Controller;

use Src\TableGateways\PersonGateway;

class PersonController {

    private $db;
    private $requestMethod;
    private $id;
    private $table;

    private $personGateway;

    public function __construct($db, $requestMethod, $id, $table)
    {
        $this->db = $db;
        $this->requestMethod = $requestMethod;
        $this->id = $id;
        $this->table = $table;

        $this->personGateway = new PersonGateway($db);
    }

    public function processRequest()
    {
        $req = (string) strtolower($this->requestMethod);

        switch ($req) {
            case 'get':
                $response = $this->get($this->id, $this->table);         
                break;
            case 'post':
                $response = $this->createUserFromRequest($this->id);                
                break;  
            case 'delete':
                $response = $this->deleteFromRequest($this->id);     
                break;                               
            default:
                $response = $this->notFoundResponse();
                break;
        }

        header($response['status_code_header']);

        if ($response['body']) {
            echo $response['body'];
        }
    }

    private function get($id, $table)
    {
        $result = $this->personGateway->find($id, $table);
        if (! $result) {
            return $this->notFoundResponse();
        }
        $response['status_code_header'] = 'HTTP/1.1 200 OK';
        $response['body'] = json_encode($result);
        return $response;
    }    

    private function deleteFromRequest($id)
    {
        $input = file_get_contents('php://input');

        $this->personGateway->delete(json_decode($input));
        $response['status_code_header'] = 'HTTP/1.1 201 Created';
        $response['body'] = null;
        return $response;
    }    

    private function createUserFromRequest($id)
    {
        $input = file_get_contents('php://input');

        $this->personGateway->insert(json_decode($input));
        $response['status_code_header'] = 'HTTP/1.1 201 Created';
        $response['body'] = null;
        return $response;
    }

    // private function validatePerson($input)
    // {
    //     if(isset(json_decode($input)->fotoUrl)) {
    //         return true;
    //     } else {
    //         if (!json_decode($input)->candidateId) {
    //             return false;
    //         } 
    //     }
    //     return true;
    // }

    // private function unprocessableEntityResponse()
    // {
    //     $response['status_code_header'] = 'HTTP/1.1 422 Unprocessable Entity';
    //     $response['body'] = json_encode([
    //         'error' => 'Invalid input'
    //     ]);
    //     return $response;
    // }

    private function notFoundResponse()
    {
        $response['status_code_header'] = 'HTTP/1.1 404 Not Found';
        $response['body'] = null;
        return $response;
    }
}