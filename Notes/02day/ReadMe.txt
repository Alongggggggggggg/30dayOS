1. IPL tips：
    a. Initial Program Loader will be loaded at address starting at 0x7c00;
    b. BIOS decides the sector is boot sector or not by judging the two bytes at 0x7f00 are 0x55aa or not;
    c. using BIOS interrupt 0x10 to show a char, this interrupt has many sub functions;
    d. use CMP JMP to implement loop of print string;
    e. "$" and "RESB" can be used to fill the unused space to 0x00;
    
2. VBox tips:
    a. the bootable floopy image file needs to be like *.img to be acceptable by the VBox;

3. Make tips:
    a. Make error: missing separator is usually caused because lines are indented with whitespaces 
    when make expects tab characters.
    