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
  <link rel="stylesheet" href="assets/css/main.css" id="main_style">
  <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,800" rel="stylesheet">
  <link href="https://cdn.materialdesignicons.com/2.0.46/css/materialdesignicons.min.css" rel="stylesheet">
  <title>Intelligent Application Development - Progetto d'esame degli studenti Fabio Andrea Petrini e Matteo Baldassarrini</title>
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

<!--Calculator-->
<div class="section section--first">

  <div style="min-height: 400px;" class="container calculator">
    <div class="row">
      <div class="col-offset-2 col-8 col-t-12 col-m-8 col-offset-2">
        <div class="calculator__content">
          <div class="form__card calculator__card-form card js-form" id="card-form">
            <div style="height: 250px;" class="calculator__card-send">
              <h4>Ocaml Differentiator</h4>
              <p>Inserisci l'espressione da derivare in una variabile reale (x).</p>
                <form class="form calculator-form" action="<?php echo $_SERVER['PHP_SELF']; ?>#outputDerivataAnchor" method="get" enctype="application/x-www-form-urlencoded">
                  <div class="form__form-group">
                    <input class="form__input js-field__email" type="text" name="function" value="<?php echo $function; ?>" placeholder="2x + cos(x) + log(2)" required>
                    <span class="form-validation"></span>
                  </div>
                  <br />  
                  <input style="background-color: #7676f8;" class="site-btn site-btn--accent form__submit " type="submit" value="Calcola derivata" />
                </form>

                <a name="outputDerivataAnchor"></a>
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

          </div>
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

</body>
</html>