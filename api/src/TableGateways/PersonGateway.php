<?php
    namespace Src\TableGateways;

    class PersonGateway {

        private $db = null;

        public function __construct($db)
        {
            $this->db = $db;
        }

        public function find($id, $table)
        {
            $statement = "SELECT * FROM ".$table." ".(($id) ? "WHERE id = ?" : "").";";

            try {
                if($id) {
                    $statement = $this->db->prepare($statement);
                    $statement->execute(array($id));
                } else {
                    $statement = $this->db->query($statement);
                }
                $result = $statement->fetchAll(\PDO::FETCH_ASSOC);
                return $result;
            } catch (\PDOException $e) {
                exit($e->getMessage());
            }    
        }         

        public function insert($input)
        {
            $id = '';
            $table = '';

            foreach ($input as $inputs) {
                foreach ($inputs as $key => $value) {
                    ${$key} = $value;
                }
            }    

            switch($table) {
                case 'escolas':
                   if($id) {
                        $statement = "
                            UPDATE ".$table."
                            SET 
                                escola = :escola
                            WHERE id = :id;
                        "; 
                    } else {
                        $statement = "
                            INSERT INTO ".$table." 
                                (escola)
                            VALUES
                                (:escola); 
                            ";                        
                    }                
                break;
                case 'turmas';
                    if($id) {
                        $statement = "
                            UPDATE ".$table."
                            SET 
                                turma = :turma,
                                escola = :escola
                            WHERE id = :id;
                        "; 
                    } else {
                        $statement = "
                            INSERT INTO ".$table." 
                                (turma, escola)
                            VALUES
                                (:turma, :escola); 
                            ";                        
                    }
                break;
                case 'users':
                    if($id) {
                        $statement = "
                            UPDATE ".$table."
                            SET 
                                username = :username,
                                password = :password,
                                email = :email,
                                file = :file
                            WHERE id = :id;
                        "; 
                    } else {
                        $statement = "
                            INSERT INTO ".$table." 
                                (username,password,email,file)
                            VALUES
                                (:username,:password,:email,:file); 
                            ";                        
                    }
                break;
            }        

            try {
                $statement = $this->db->prepare($statement);

                switch($table) {
                    case 'escolas':
                        if($id) {
                            $statement->execute(array(
                                'id' => (int) $id,
                                'escola' => $escola ? $escola : ''
                            ));  
                        } else {
                            $statement->execute(array(
                                'escola' => $escola ? $escola : ''
                            ));                            
                        }                    
                    break;
                    case 'turmas';
                        if($id) {
                            $statement->execute(array(
                                'id' => (int) $id,
                                'turma' => $turma ? $turma : '',
                                'escola' => $escola ? $escola : ''
                            ));  
                        } else {
                            $statement->execute(array(
                                'turma' => $turma ? $turma : '',
                                'escola' => $escola ? $escola : ''
                            ));                            
                        }
                    break;
                    case 'users':
                        if($id) {
                            $statement->execute(array(
                                'id' => (int) $id,
                                'username' => $username ? $username : '',
                                'password' => $password ? $password : '',
                                'email' => $email ? $email : '',
                                'file' => $file ? $file : ''
                            ));  
                        } else {
                            $statement->execute(array(
                                'username' => $username ? $username : '',
                                'password' => $password ? $password : '',
                                'email' => $email ? $email : '',
                                'file' => (isset($file)) ? $file : ''
                            ));                            
                        }
                    break;
                }                  

                return $statement->rowCount();
            } catch (\PDOException $e) {
                exit($e->getMessage());
            } 
        }

        public function delete($input)
        {
            $id = '';
            $table = '';

            foreach ($input as $inputs) {
                foreach ($inputs as $key => $value) {
                    ${$key} = $value;
                }
            }  

            $statement = "
                DELETE FROM ".$table."
                WHERE id = :id;
            ";

            try {
                $statement = $this->db->prepare($statement);
                $statement->execute(array('id' => $id));
                return $statement->rowCount();
            } catch (\PDOException $e) {
                exit($e->getMessage());
            }              
        }        
    }