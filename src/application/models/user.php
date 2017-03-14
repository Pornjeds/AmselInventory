<?php
Class User extends CI_Model
{
 function login($username, $password)
 {
   $this -> db -> select('UserID, UserName, Password');
   $this -> db -> from('Users');
   $this -> db -> where('UserName', $username);
   $this -> db -> where('Password', MD5($password));
   $this -> db -> limit(1);

   $query = $this -> db -> get();

   if($query -> num_rows() == 1)
   {
     return $query->result();
   }
   else
   {
     return false;
   }
 }
}
?>
