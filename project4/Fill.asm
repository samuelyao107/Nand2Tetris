

(LOOP)
    // 1. LECTURE DU CLAVIER
    @KBD      // Le clavier est mappé à l'adresse 24576
    D=M       // On lit la valeur du clavier. S'il n'y a pas de touche, D=0.

    // 2. CHOIX DE LA COULEUR
    @WHITE
    D;JEQ     // Si D == 0 (aucune touche), on saute à (WHITE)

(BLACK)
    @color
    M=-1      // Touche pressée : couleur = -1 (1111111111111111, soit 16 pixels noirs)
    @DRAW
    0;JMP     // On saute à la routine de dessin

(WHITE)
    @color
    M=0       // Aucune touche : couleur = 0 (0000000000000000, soit 16 pixels blancs)

(DRAW)
    // 3. INITIALISATION DU DESSIN
    @SCREEN   // Adresse de base de l'écran (16384)
    D=A
    @addr
    M=D       // addr = SCREEN

    @8192     // L'écran contient 8192 blocs de 16 pixels (512*256 / 16)
    D=A
    @n
    M=D       // n = 8192 (le nombre de fois qu'on va devoir écrire)

    @i
    M=0       // i = 0 (notre compteur)

(DRAW_LOOP)
    // 4. LA BOUCLE QUI REMPLIT L'ÉCRAN
    // Condition de sortie : si i == n, on a fini l'écran, on retourne écouter le clavier
    @i
    D=M
    @n
    D=D-M
    @LOOP
    D;JEQ     // Si i - n == 0, on retourne à (LOOP)

    // Écriture dans la mémoire vidéo (RAM[addr] = color)
    @color
    D=M       // On charge la couleur (0 ou -1) dans D
    @addr
    A=M       // ASTUCE MAGIQUE : A prend l'adresse stockée dans addr (pointer)
    M=D       // On écrit la couleur à l'adresse mémoire pointée

    // Passage au bloc de 16 pixels suivant
    @addr
    M=M+1     // addr = addr + 1 (Contrairement à ton code précédent, on ne saute pas de ligne, on remplit tout à la suite)

    // Incrémentation du compteur
    @i
    M=M+1     // i = i + 1

    @DRAW_LOOP
    0;JMP     // On recommence pour le bloc de pixels suivant