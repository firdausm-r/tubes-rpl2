<style>
    .carousel-item>img{
        object-fit:fill !important;
    }
    #carouselExampleControls .carousel-inner{
        height:280px !important;
    }
    #search-field .form-control.rounded-pill{
        border-top-right-radius:0 !important;
        border-bottom-right-radius:0 !important;
        border-right:none !important
    }
    #search-field .form-control:focus{
        box-shadow:none !important;
    }
    #search-field .form-control:focus + .input-group-append .input-group-text{
        border-color: #86b7fe !important
    }
    #search-field .input-group-text.rounded-pill{
        border-top-left-radius:0 !important;
        border-bottom-left-radius:0 !important;
        border-right:left !important
    }
    .post-item{
        transition:all .2s ease-in-out;
    }
    .post-item:hover{
        transform:scale(1.02);
    }
</style>
<!-- Header-->
<section class="py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div id="carouselExampleControls" class="carousel slide bg-dark" data-ride="carousel">
                    <div class="carousel-inner">
                        <?php 
                            $upload_path = "uploads/banner";
                            if(is_dir(base_app.$upload_path)): 
                            $file= scandir(base_app.$upload_path);
                            $_i = 0;
                                foreach($file as $img):
                                    if(in_array($img,array('.','..')))
                                        continue;
                            $_i++;
                                
                        ?>
                        <div class="carousel-item h-100 <?php echo $_i == 1 ? "active" : '' ?>">
                            <img src="<?php echo validate_image($upload_path.'/'.$img) ?>" class="d-block w-100  h-100" alt="<?php echo $img ?>">
                        </div>
                        <?php endforeach; ?>
                        <?php endif; ?>
                    </div>
                    <button class="carousel-control-prev" type="button" data-target="#carouselExampleControls" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-target="#carouselExampleControls" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                    </div>
            </div>
        </div>
        <div class="row justify-content-center my-4">
            <div class="col-lg-6 col-md-8 col-sm-12 col-xs-12">
                <div class="input-group input-group-lg" id="search-field">
                    <input type="search" class="form-control form-control-lg  rounded-pill" aria-label="Search Post Input" id="search" placeholder="Cari Postingan">
                    <div class="input-group-append">
                        <span class="input-group-text rounded-pill bg-transparent"><i class="fa fa-search"></i></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row row-cols-xl-4 row-cols-md-3 row-cols-sm-1 gx-2 gy-2">
            <?php 
                $posts = $conn->query("SELECT p.*, c.name as `category` FROM `post_list` p inner join category_list c on p.category_id = c.id where p.status = 1  and p.`delete_flag` = 0 order by abs(unix_timestamp(p.date_created)) desc");
                while($row = $posts->fetch_assoc()):
            ?>
            <div class="col post-item">
                <a href="./?p=posts/view_post&id=<?= $row['id'] ?>" class="card rounded-0 shadow text-decoration-none text-reset">
                    <div class="card-body">
                        <div class="mb-2 text-right">
                                <small class="badge badge-light border text-dark rounded-pill px-3"><i class="far fa-circle"></i> <?= $row['category'] ?></small>
                        </div>
                        <h3 class="card-title w-100 font-weight-bold"><?= $row['title'] ?></h3>
                        <div class="card-text truncate-3 text-muted text-sm"><?= strip_tags($row['content']) ?></div>
                        <div class="mb-2 text-right">
                            <small class="text-muted"><i><?= date("Y-m-d h:i A", strtotime($row['date_created'])) ?></i></small>
                        </div>
                    </div>
                </a>
            </div>
            <?php endwhile; ?>
        </div>
        <!-- News, gagal euy di API nya  -->
        <?php                
         /* <-- Silakan register di newsapi.org untuk mendapatkan API_KEY */
        //$alamatAPI = 'https://newsapi.org/v2/everything?' +
        //                'q=Tuberculosis&' +
        //                'sortBy=relevancy&' +
        //                'apiKey=393360438ee04a978ca214dfd34392c6';

        # ambil data json dari $alamatAPI
        #$data = file_get_contents($alamatAPI);
        # parsing variabel $data ke dalam array
        #$dataBerita = json_decode($data);

        #if ($dataBerita->status === "ok") {
            # tampilkan menggunakan perulangan
        #    foreach ($dataBerita->articles as $berita) {
         #       echo "<h3><a href='{$berita->url}'>{$berita->title}</a></h3>";
        
          #      if ($berita->urlToImage) {
           #         echo "<img style='width: 10rem' src='{$berita->urlToImage}'>";
            #    }
        
          #      echo "<p>{$berita->description}</p>";
           #     echo "<hr>";
        #    }
        #}
        ?>


    </div>
</section>


<?php
//script API FIX dari newsdata.io
    function curl($url){
    $ch = curl_init(); 
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
    $output = curl_exec($ch);  
    curl_close($ch);      
    return $output;
}

$curl = curl("https://api.worldnewsapi.com/search-news?api-key=ca525c7ff3684eeba55cda34209dd907&text=tuberculosis&number=3");

// mengubah JSON menjadi array
$data = json_decode($curl, TRUE);
    
    //$url = "https://newsapi.org/v2/everything?q=Tuberculosis&sortBy=relevancy&api//=393360438ee04a978ca214dfd34392c6";
    //$fga = file_get_contents($url);
    //$json = json_decode($fga, true);
?>

<div class="container mt-5 mb-5">
    <hr>
    <br>
    
    <h2>
        Berita
    </h2>
    
    <div class="row mt-5">
        
        
        <?php foreach ($data['news'] as $view){ ?>
        <div class="col-sm-4">
            <a href="<?= $view['url']?>" style="text-decoration: none;color: black;" target="kanan">
                <div class="card">
                    <div class="card-body">
                        <div class="mt-3 mb-3">
                            <img src="<?= $view['image']?>" width="100%">
                        </div>
                        <?= $view['title'];?>
                        <br><br>
                    </div>
                </div>
            </a>
        </div>
        <?php } ?>
        
        <div class="mt-5 mb-5">
            <a href="berita.php">Berita lainnya</a>
        </div>

    </div>
    

</div>
<!--
<script>
    //ceritanya untuk memanggil API, tapi kok ga muncul?
    const newsdetails = document.getElementById("newsdetails");
    //var url = 'https://newsapi.org/v2/everything?' +
    //      'q=Tuberculosis&' +
    //      'sortBy=relevancy&' +
    //      'pageSize=5&' +
    //      'page=2&' +
    //      'apiKey=393360438ee04a978ca214dfd34392c6';

    // Array
    var newsDataArr = [];

    // apis 
    const API_KEY = "393360438ee04a978ca214dfd34392c6";
    const TBC = 'https://newsapi.org/v2/everything?' +
          'q=Tuberculosis&' +
          'sortBy=relevancy&' +
          'apiKey=393360438ee04a978ca214dfd34392c6';


        const fetchTBC = async () => {
            const response = await fetch(TBC+API_KEY);
            newsDataArr = [];
            if(response.status >=200 && response.status < 300) {
                const myJson = await response.json();
                newsDataArr = myJson.articles;
            } else {
                // handle errors
                console.log(response.status, response.statusText);
                newsdetails.innerHTML = "<h5>No data found.</h5>"
                return;
            }
            displayNews();
        }

          function displayNews() {

            newsdetails.innerHTML = "";

            // if(newsDataArr.length == 0) {
            //     newsdetails.innerHTML = "<h5>No data found.</h5>"
            //     return;
            // }

            newsDataArr.forEach(news => {

                var date = news.publishedAt.split("T");
                
                var col = document.createElement('div');
                col.className="col-sm-12 col-md-4 col-lg-3 p-2 card";

                var card = document.createElement('div');
                card.className = "p-2";

                var image = document.createElement('img');
                image.setAttribute("height","matchparent");
                image.setAttribute("width","100%");
                image.src=news.urlToImage;

                var cardBody = document.createElement('div');
                
                var newsHeading = document.createElement('h5');
                newsHeading.className = "card-title";
                newsHeading.innerHTML = news.title;

                var dateHeading = document.createElement('h6');
                dateHeading.className = "text-primary";
                dateHeading.innerHTML = date[0];

                var discription = document.createElement('p');
                discription.className="text-muted";
                discription.innerHTML = news.description;

                var link = document.createElement('a');
                link.className="btn btn-dark";
                link.setAttribute("target", "_blank");
                link.href = news.url;
                link.innerHTML="Read more";

                cardBody.appendChild(newsHeading);
                cardBody.appendChild(dateHeading);
                cardBody.appendChild(discription);
                cardBody.appendChild(link);

                card.appendChild(image);
                card.appendChild(cardBody);

                col.appendChild(card);

                newsdetails.appendChild(col);
            });

            }
    $(function(){
        $('#search').on('input', function(){
            var _search = $(this).val().toLowerCase()
            $('.post-item').each(function(){
                var _text = $(this).text().toLowerCase()
                _text = _text.trim()
                if(_text.includes(_search) === false){
                    $(this).toggle(false)
                }else{
                    $(this).toggle(true)
                }
            })
        })
    })
</script>