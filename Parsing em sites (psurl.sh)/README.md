# Parsing de sites 

 #### Objetivo 
O objetivo deste script usando Bash Script é identificar possiveis domínios de um site fazendo parsing no código fonte HTML
do (s) site (s).

 ---
 
 #### Utilização 
O script deve funcionar conforme saída abaixo. 

- Baixe o script em um diretório vazio
- Dê permissões de escritas
- Execute
- Informe o site alvo 

 ```
┌─[✗]─[root@0xmachine]─[/opt/scripts]
└──╼ #ll
total 4.0K
-r-xr--r-- 1 root root 1.8K Feb  6 16:51 parsing.sh
┌─[root@0xmachine]─[/opt/scripts]
└──╼ #chmod 544 parsing.sh
┌─[root@0xmachine]─[/opt/scripts]
└──╼ #./parsing.sh
   _____                  __                 __________                   .__
  /     \ _____    ______/  |_  ___________  \______   _____ _______ _____|__| ____   ____
 /  \ /  \ \__  \  /  ___\   ___/ __ \_  __ \  |     ___\__ \ \_  __ /  ___|  |/    \ / ___\
/    Y    \/ __ \_\___ \ |  | \  ___/|  | \/  |    |    / __ \|  | \ \___ \|  |   |  / /_/  >
\____|__  (____  /____  >|__|  \___  |__|     |____|   (____  |__| /____  |__|___|  \___  /
        \/     \/     \/           \/                       \/          \/        \/_____/
........................................................................blog.isweluiz.com.br

Ex de utilizaçção - www.globo.com.br , www.uol.com.br

Declare o site: www.globo.com.br
2019-02-06 16:58:56 URL:http://www.globo.com/ [734244/734244] -> "index.html" [1]

;.............................................
Buscando hosts

assine.globo.com
canaisglobosat.globo.com
casavogue.globo.com
extra.globo.com
g1.globo.com
globoesporte.globo.com
globoplay.globo.com
globosatplay.globo.com
grupoglobo.globo.com
gshow.globo.com
kogut.oglobo.globo.com
oglobo.globo.com
revistacasaejardim.globo.com
revistacrescer.globo.com
revistamarieclaire.globo.com
revistamonet.globo.com
revistapegn.globo.com
revistaquem.globo.com
s2.glbimg.com
s.glbimg.com
sportv.globo.com
vogue.globo.com
www.globo.com
www.techtudo.com.br
;.............................................
Resolvendo hosts

assine.globo.com has address 131.0.25.249
canaisglobosat.globo.com has address 131.0.25.4
casavogue.globo.com has address 186.192.81.157
extra.globo.com has address 201.7.177.130
g1.globo.com has address 186.192.81.31
globoesporte.globo.com has address 186.192.81.25
globoplay.globo.com has address 131.0.25.251
globosatplay.globo.com has address 186.192.81.29
grupoglobo.globo.com has address 201.7.177.179
gshow.globo.com has address 186.192.81.35
kogut.oglobo.globo.com has address 186.192.81.17
oglobo.globo.com has address 201.7.177.131
revistacasaejardim.globo.com has address 186.192.81.156
revistacrescer.globo.com has address 186.192.81.156
revistamarieclaire.globo.com has address 186.192.81.156
revistamonet.globo.com has address 186.192.81.157
revistapegn.globo.com has address 186.192.81.158
revistaquem.globo.com has address 186.192.81.156
s2.glbimg.com has address 186.192.91.9
s.glbimg.com has address 186.192.91.5
sportv.globo.com has address 186.192.81.26
vogue.globo.com has address 186.192.81.157
www.globo.com has address 186.192.81.5
www.techtudo.com.br has address 186.192.81.152


 ```


For more alternatives 
 **Contacte me** 

-My linkedin [Linkedin](https://www.linkedin.com/in/isweluiz/)


 
