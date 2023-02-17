<?php 
    function curl($url){
    $ch = curl_init(); 
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
    $output = curl_exec($ch);  
    curl_close($ch);      
    return $output;
}

$curl = curl("https://newsdata.io/api/1/news?apikey=pub_1725264b653c62c98eda24ee1f030990a7000&q=tuberculosis%Tuberculosis");

// mengubah JSON menjadi array
$data = json_decode($curl, TRUE);
    
    //$url = "https://newsapi.org/v2/everything?q=Tuberculosis&sortBy=relevancy&api//=393360438ee04a978ca214dfd34392c6";
    //$fga = file_get_contents($url);
    //$json = json_decode($fga, true);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <title>Berita</title>
</head>
<body>
    
    <div class="mt-5 mb-5">
        <div class="container">
            <div class="mt-5 mb-5">
                <a href="index.php" class="btn btn-primary">Back to Home</a>
            </div>

            <h1>
                Berita Lainnya
            </h1>

            <div class="mt-5 mb-5">
                <div class="row">
                    <?php foreach ($data['results'] as $view){ ?>
                        <div class="col-sm-3 mb-3">
                            <a href="<?= $view['link']?>" style="text-decoration: none;color: black;" target="kanan">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="mt-3 mb-3">
                                            <img src="<?= $view['image_url']?>" width="100%">
                                        </div>
                                        <?= $view['title'];?>
                                        <br><br>
                                        <div style="opacity: 0.5;">
                                            <?= $view['description'];?>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    <?php } ?>
                </div>
            </div>  



        </div>
    </div>



</body>
</html>