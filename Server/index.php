<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "libridb";

$conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
// set the PDO error mode to exception
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//process client request (via URL)
header ("Content-Type_application/json");

//Verifica che sia stata passata un numero di funzione da eseguire
// if(empty($_GET['funzione']))
// 	$funzione = null;
// else
$funzione = $_GET['funzione'];

switch($funzione)
{
	case '0':
		//Query elenco tutti libri
		$stmt = $conn->prepare("SELECT titolo FROM libri");
		$stmt->execute();
		$res = $stmt->fetchAll();
		
		//inizializzazione variabili
		$arr = array();
		$i = 0;
		
		foreach($res as $row)
		{
			$arr[$i] = $row['titolo'];
			$i = $i + 1;
		}
		
		deliver_response(200,"all books", $arr);
		break;
		
	case '1':
		//inizializzazione variabili
		$arr = array();
		$i = 0;
		
		$stmt = $conn->prepare("SELECT COUNT(libri.id) 
								FROM libri JOIN reparti on libri.reparto = reparti.id
								JOIN categorielibri on libri.id = categorielibri.libro
								WHERE reparti.tipo = 'Fumetti' and categorielibri.categoria = 'Ultimi arrivi'");
		$stmt->execute();
		$res = $stmt->fetchAll();

		//var_dump($res);
		foreach($res as $row)
		{
			$arr[$i] = $row['COUNT(libri.id)'];
			$i = $i + 1;
		}
		
		deliver_response(200,"fumetti ", $arr);
		break;

	case '2':
		//inizializzazione variabili
		$arr=array();
		$i=0;
		
		$stmt = $conn->prepare("SELECT titolo 
								FROM libri JOIN categorielibri ON libri.id = categorielibri.libro
								JOIN categorie on categorielibri.categoria = categorie.tipo
								WHERE sconto > 0
								ORDER BY sconto");
		$stmt->execute();
		$res = $stmt->fetchAll();

		//var_dump($res);
		foreach($res as $row)
		{
			$arr[$i] = $row['titolo'];
			$i = $i + 1;
		}

		deliver_response(200,"scontati", $arr);
		break;

	case '3':
		//inizializzazione variabili
		$arr = array();
		$i=0;

		//split date inserite in input
		$tmpInizio = explode('/', $_GET['data1']);;
		$tmpFine = explode('/', $_GET['data2']);

		//Timestamp data inizio ricerca
		$dataInizio = mktime(0,0,0,$tmpInizio[1],$tmpInizio[0],$tmpInizio[2]);

		//Timestamp data inizio ricerca
		$dataFine = mktime(0,0,0,$tmpFine[1],$tmpFine[0],$tmpFine[2]);

		$stmt = $conn->prepare("SELECT titolo 
								FROM libri
								WHERE dataArch BETWEEN ".$tmpInizio[2].$tmpInizio[1].$tmpInizio[0]." AND ".$tmpFine[2],$tmpFine[1],$tmpFine[0]);
		$stmt->execute();
		$res = $stmt->fetchAll();

		//var_dump($res);
		foreach($res as $row)
		{
			$arr[$i] = $row['titolo'];
			$i = $i + 1;
		}
		
		deliver_response(200,"date    ", $arr);
		break;

	case '4':
		//Conversione file JSON in array associativo
		$dati = conversioneDati('../FileJSON/Libri.json');
		$user = conversioneDati('../FileJSON/Utenti.json');
		$carrelli = conversioneDati('../FileJSON/Carrelli.json');
		$libriCarr = conversioneDati('../FileJSON/LibriCarrello.json');

		$idCarr = $_GET['codice'];
		$utente="";
		$tit = array();
		$nCopie = "";

		foreach($carrelli['carrello'] as $carr)
		{
			if($idCarr ==  $carr["id"])
				$utente = $carr["utente"];
		}

		foreach($libriCarr['librocarrello'] as $associazione)
		{
			if($associazione['carrello'] === $idCarr);
			{
				foreach($dati['libro'] as $book)
				{
					if($book['id'] === $associazione['libro'])
						array_push($tit, array('titolo'=>$book['titolo'], 'nCopie' => $associazione['nCopie']));
				}

				//$nCopie = $associazione['nCopie'];
			}
		}

		$arr = array();
		array_push($arr, array('utente'=>$utente, 'libri' => $tit));

		deliver_response(200,"carrello", $arr);
		break;

	default:
		deliver_response(400,"Invalid request", NULL);
		break;
}

//Funzione per invio della risposta al client
function deliver_response($status, $status_message, $data)
{
	header("HTTP/1.1 $status $status_message");
	
	$response ['status']=$status;
	$response['status_message']=$status_message;
	$response['data']=$data;
	
	$json_response=json_encode($response);
	echo $json_response;
}

//Funzione per la conversione da file JSON a array associativo
function conversioneDati($json)
{
	$str = file_get_contents($json);
	$dati = json_decode($str, true); 
	
	return $dati;
}
?>