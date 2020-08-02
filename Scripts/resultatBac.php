#!/usr/bin/php -q
<?php
error_reporting(E_ALL);
require "/var/lib/asterisk/agi-bin/phpagi/src/phpagi.php";
//require "phpagi.php"; surement ca dans ton cas

GLOBAL $agi ; 
$agi = new AGI(); 


// RETRIEVING THE PARAMETER
$givenNumTable = $agi->get_variable('numTable',true);

// DATABASE INFORMATIONS
$host="localhost";
$db="Baccalaureat";
$user="root";
$pass="cloud";


// QUERIES TO EXECUTE
$authenticationQuery = "SELECT etudiant.numTable FROM etudiant WHERE numTable = '$givenNumTable' ";

$resultsQuery = " SELECT  resultat.admission as admission, resultat.moyenne as moyenne, resultat.mention as mention FROM etudiant
INNER JOIN resultat WHERE ( (etudiant.numTable = resultat.numTable) and (etudiant.numTable = '$givenNumTable') ) ";



  $con =mysqli_connect($host,$user,$pass,$db);

  if (mysqli_connect_errno()) {
			  $agi->verbose("Echec de connexion à MySQL: " . mysqli_connect_error());
			  exit();
   }

  $valid = 0; 
	
  // GOOD NUMTABLE
  if( ($status=mysqli_query($con,$authenticationQuery)) && ($you=mysqli_fetch_assoc($status)) ) {

			$valid =1; 
			$agi->set_variable('valid',$valid);

			// GOOD RETRIEVAL OF RESULTS
			if( $results=mysqli_query($con,$resultsQuery)) {


					$row=mysqli_fetch_assoc($results);
					mysqli_free_result($results);

					$admis = $row["admission"]; 
					$moyenne= $row["moyenne"];
					$mention= $row["mention"];

					$agi->set_variable('admis',$admis);
					$agi->set_variable('moyenne',$moyenne);
					$agi->set_variable('mention',$mention);

			}

  			// BAD RETRIEVAL OR EEROR
	 		else{

	 			die("Une erreur est survenue dans la recherche du résultat : ".mysqli_error($con));
			}

	}

  // BAD NUMTABLE OR EEROR
	else {

			$agi->set_variable('valid',$valid);
	}


	unset($agi);
	mysqli_close($con);
?>
