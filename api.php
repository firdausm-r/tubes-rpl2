<?php

    $url = "https://newsapi.org/v2/everything?q=Tuberculosis&sortBy=relevancy&apiKey=393360438ee04a978ca214dfd34392c6";
    $fga = file_get_contents($url);
    $json = json_decode($fga, true);


    foreach ($json['articles'] as $view){
        echo $view['title']. "<br>";
    }

    

?>