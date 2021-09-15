<?php require("config.php"); ?>

<?php
  if (!empty($_GET)) {
          $inputString = str_replace('+', '%2B', $_GET['function']);
          $function = urldecode(trim($inputString));
          $cmd = $pathOcamlDerivaFunzioni . ' ' . '"' . $function . '"';
          $cmdResult = exec($cmd);


          // echo "<strong>comando inviato:</strong> " . $cmd;
          // echo '<br />';
          // echo "<strong>funzione input:</strong> " . $function;
          // echo '<br />';
          // echo '<strong>derivata:</strong> ' . $cmdResult;
  }
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<script>
	MathJax = {
	  loader: {load: ['input/asciimath', 'output/chtml']}
	}
	</script>
	<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
	<script type="text/javascript" id="MathJax-script" async
	  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/mml-chtml.js">
	</script>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="assets/css/tablesaw.css">
  <link rel="stylesheet" href="assets/css/main.css" id="main_style">
  <link rel="stylesheet" href="assets/css/jquery-ui.min.css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,800" rel="stylesheet">
  <link href="https://cdn.materialdesignicons.com/2.0.46/css/materialdesignicons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/css/jquery-ui.min.css">
  <script src="assets/js/vendor/tablesaw.js"></script>
  <script src="assets/js/vendor/tablesaw-init.js"></script>
  <title>Intelligent Application Development - Progetto d'esame degli studenti Fabio Andrea Petrini e Matteo Baldassarrini</title>
  <link rel="icon" href="assets/img/Logo_32x32.png" type="image/png">
  <link rel="stylesheet" href="assets/css/custom.css">
</head>
<body>


<!--Main menu-->
<div class="menu">
  <div class="container menu__wrapper">
    <div class="row">
      <div class="menu__logo menu__item">
        <a href="<?php echo $_SERVER['PHP_SELF']; ?>">
          <img style="width: 120px;" src="assets/img/logo_unipg.gif" />
        </a>
        <h4 class="">Intelligent Application Development</h4>
        <span style="text-align: left; font-size: 18px;">Progetto d'esame</span></p>
      </div>
    </div>
  </div>
</div>
<!--Main menu-->

<!--Mobile menu-->
<div class="mobile-menu d-none d-t-block">
  <div class="container">
    <div class="mobile-menu__logo">
      <svg class="menu__logo-img" xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48">
        <path data-name="Sigma symbol" class="svg-element"
              d="M237.418,8583.56a12.688,12.688,0,0,0,.419-3.37c-0.036-5.24-2.691-9.68-7.024-13.2h-3.878a20.819,20.819,0,0,1,4.478,13.01c0,4.56-2.456,10.2-6.413,11.4a16.779,16.779,0,0,1-2.236.51c-10.005,1.55-14.109-17.54-9.489-23.31,2.569-3.21,6.206-4.08,11.525-4.08h17.935A24.22,24.22,0,0,1,237.418,8583.56Zm-12.145-24.45c-8.571.02-12.338,0.98-16.061,4.84-6.267,6.49-6.462,20.69,4.754,27.72a24.092,24.092,0,1,1,27.3-32.57h-16v0.01Z"
              transform="translate(-195 -8544)"/>
      </svg>
    </div>
    <button type="button" class="mobile-menu__close">
      <span><i class="mdi mdi-close" aria-hidden="true"></i></span>
    </button>
    <nav class="mobile-menu__wrapper">
      <ul class="mobile-menu__ul">
        <li class="mobile-menu__li mobile-menu__li-collapse"><a class="link link--dark-gray">Home
          <span><i class="mdi mdi-chevron-down"></i></span>
        </a></li>
        <li class="mobile-menu__ul--collapsed">
          <ul class="mobile-menu__ul">
            <li class="mobile-menu__li"><a class="link link--gray" href="index.html">Mobile App</a></li>
            <li class="mobile-menu__li"><a class="link link--gray" href="02_messenger.html">Messenger</a></li>
            <li class="mobile-menu__li"><a class="link link--gray" href="03_webapp.html">Web App</a></li>
            <li class="mobile-menu__li"><a class="link link--gray" href="04_desktop.html">Desktop App</a></li>
          </ul>
        </li>
        <li class="mobile-menu__li"><a href="05_features.html" class="link link--dark-gray">Features</a></li>
        <li class="mobile-menu__li"><a href="06_pricing.html" class="link link--dark-gray">Pricing</a></li>
        <li class="mobile-menu__li"><a href="10_get-app.html" class="site-btn site-btn--accent">Get the Sigma</a></li>
        <li class="mobile-menu__li mobile-menu__li-collapse"><a class="link link--dark-gray">En
          <span><i class="mdi mdi-chevron-down"></i></span></a></li>
        <li class="mobile-menu__ul--collapsed">
          <ul class="mobile-menu__ul">
            <li class="mobile-menu__li"><a href="" class="link link--gray link--gray-active">En</a></li>
            <li class="mobile-menu__li"><a href="" class="link link--gray">Fr</a></li>
            <li class="mobile-menu__li"><a href="" class="link link--gray">Ch</a></li>
          </ul>
        </li>
      </ul>
    </nav>
  </div>
</div>
<!--Mobile menu-->



<!--Calculator-->
<div class="section section--first">

  <div style="min-height: 400px;" class="container calculator">
    <div class="row">
      <div class="col-offset-2 col-8 col-t-12 col-m-8 col-offset-2">
        <div class="calculator__content">
          <form class="form calculator-form" action="<?php echo $_SERVER['PHP_SELF']; ?>" method="get" enctype="application/x-www-form-urlencoded">
            <div class="form__card calculator__card-form card js-form" id="card-form">
              <div style="height: 250px;" class="calculator__card-send">
                <h4>Ocaml Differentiator</h4>
                <p>Inserisci l'espressione da derivare in una variabile reale (x).</p>
                <div class="form__form-group">
                  <input class="form__input js-field__email" type="text" name="function" placeholder="2x + cos(x) + log(2)" required>
                  <span class="form-validation"></span>
                </div>
				        <br />  
                <input style="background-color: #7676f8;" class="site-btn site-btn--accent form__submit " type="submit" value="Calcola derivata" />
              </div>

              <?php if (!empty($inputString)): ?>
                <div id="outputDerivata">
                    <?php 
                        if (!empty($cmdResult) && $cmdResult == 'Error_DivisionByZero') {
                          echo "Errore: impossibile effettuare una divisione per zero.";
                        } else if (!empty($cmdResult)) {
                          echo htmlspecialchars('`') . "dx/dt($function) = $cmdResult" . htmlspecialchars('`');
                        } else {
                          echo "Errore: output vuoto, verificare la correttezza della funzione in input.";
                        }
                      ?>
                  <br />
                </div>
              <?php endif; ?>


            </div>
          </form>


        </div>
      </div>
	  

    </div>
  </div>
</div>
<!--Calculator-->



<!--Footer menu-->
<div class="container footer-menu">
  <div class="row">
    <div class="col-12">
      

    </div>
  </div>
</div>
<!--Footer menu-->

<hr />

<!--Footer-->
<div class="footer">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <p>Progetto dell'esame Intelligent Application Development</p>
		<p>Realizzato dagli studenti Fabio Andrea Petrini e Matteo Baldassarrini</p>
      </div>
    </div>
  </div>
</div>
<!--Footer-->

<script src="assets/js/vendor/jquery-2.2.4.min.js"></script>
<script src="assets/js/vendor/jquery.waypoints.js"></script>
<script src="assets/js/menu.js"></script>
<script src="assets/js/vendor/jquery.mask.min.js"></script>
<script src="assets/js/mobile-menu.js"></script>
<script src="assets/js/style-switcher.js"></script>
<script src="assets/js/sidebar.js"></script>
<script src="assets/js/vendor/device.js"></script>
<script src="assets/js/calculator.js"></script>
<script src="assets/js/validation.js"></script>
</body>
</html>