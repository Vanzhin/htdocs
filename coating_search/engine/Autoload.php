<?php

namespace app\engine;
class Autoload
{
    public function loadClass($className){

        $filename = str_replace('\\',DIRECTORY_SEPARATOR, "{$className}.php");
        if(strpos($filename,'app') === 0){
            $filename = substr_replace($filename,ROOT,0,strlen('app'));

        }
        if (file_exists($filename)){
                include $filename;
        }
    }
}