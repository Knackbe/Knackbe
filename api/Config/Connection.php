<?php

/**
 * @author damith
 * @copyright 2011
 */

class createConnection //create a class for make connection
{
    var $host="182.50.133.83";
    var $username="talhunt";    // specify the sever details for mysql
    Var $password="talhunt123";
    var $database="infotantra_01";
    var $myconn;

    function connectToDatabase() // create a function for connect database
    {

        $conn= mysqli_connect($this->host,$this->username,$this->password,$this->database);

        if(!$conn)// testing the connection
        {
            die ("Cannot connect to the database");
        }

        else
        {

            $this->myconn = $conn;

            //echo "Connection established";

        }

        return $this->myconn;

    }

    function closeConnection() // close the connection
    {
        mysqli_close($this->myconn);

        //echo "Connection closed";
    }

}

?>