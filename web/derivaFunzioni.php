<html>
        <body>
                <h1>Derivatore Ocaml</h1>
                <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="get" enctype="application/x-www-form-urlencoded">
                Inserire funzione:
                <input type="input" name="function" value="" />
                <input type="submit" name="submit" value="submit"/>
                </form>
                <?php
                        if (!empty($_GET)) {
                                $inputString = str_replace('+', '%2B', $_GET['function']);

                                $function = urldecode(trim($inputString));

                                $cmd = '/home/u1479-skyqngkbvhjz/ocaml/derivaFunzioni' . ' ' . '"' . $function . '"';
                                echo "<strong>comando inviato:</strong> " . $cmd;
                                echo '<br />';
                                echo "<strong>funzione input:</strong> " . $function;
                                echo '<br />';
                                $cmdResult = exec($cmd);
                                echo '<strong>derivata:</strong> ' . $cmdResult;
                        }
                ?>
        </body>
</html>