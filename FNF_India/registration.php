<?php
ini_set("display_errors","0");
$conn=mysqli_connect('localhost', 'root', '', 'preonboarding_with_basicdata');

if(!$conn){
    echo 'failed to connect'.mysqli_error($conn);
}


$response = array();

	
	

$first_name = $_POST['first_name'];
$email_id = $_POST['email_id'];
$source_id = $_POST['source_id'];
$mobile_number = $_POST['mobile_number'];
$source_name = $_POST['source_name'];

$count =mysqli_query($conn, "SELECT * FROM candidate_sourcing WHERE year(date_time)='".date('Y')."' && month(date_time)='".date('m')."' ORDER BY id DESC");


/* $idval = mysqli_fetch_array($count);

 $ptcid="PTCID-00".($idval['id']+1);
 $cdate=date('Y-m-d');
  */
 
 
$applicantid = mysqli_fetch_assoc($count);
   if(mysqli_num_rows($count) == 0)
       $id = '0001';
   else
   {
       $idno = substr($applicantid['applicant_id'],4);
       if(strlen($idno + 1) == 1)
           $id = "000".($idno + 1);
       else if(strlen($idno + 1) == 2)
           $id = '00'.($idno + 1);
       else if(strlen($idno + 1) == 3)
           $id = '0'.($idno + 1);
       else if(strlen($idno + 1) == 4)
           $id = ($idno + 1);
       else
           $id = '0001';
   }
 

 
  
$q1= "SELECT * FROM candidate_sourcing WHERE email_id='".$_POST['email_id']."'";
   
$r=mysqli_query($conn,$q1);
  $no=mysqli_num_rows($r);


if($no==true)
{
    echo "You have already registered .... Please Login !!!!";
exit();
}
else
{
   
        $qry = "INSERT INTO  candidate_sourcing(user_id,applicant_id,email_id,first_name,mobile_number,source_name,source_id,date_time) 
    Values(NULL,'".date('y').date('m').$id."','$email_id','$first_name','$mobile_number','$source_name','$source_id','".date('Y-m-d H:i:s')."')";

  
$q1=mysqli_query($conn,$qry);
if($q1)
{
$response["success"]=1;
$response["message"]="Registration Successfull";
echo json_encode($response);
   

    
}
else
{
$response["success"]=0;
$response["message"]=mysqli_error($conn);
echo json_encode($response);
}
mysqli_close($conn);
}




?>