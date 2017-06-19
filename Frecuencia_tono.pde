import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioInput in;
FFT fft;
String note;// name of the note
int n;//int value midi note
int r,g,b; //coloresh
color c;//color
float hertz;//frequency in hertz
float midi;//float midi note
int noteNumber;//variable for the midi note
 
 
int sampleRate= 44100;//sapleRate of 44100
 
float [] max= new float [sampleRate/2];//array that contains the half of the sampleRate size, because FFT only reads the half of the sampleRate frequency. This array will be filled with amplitude values.
float maximum;//the maximum amplitude of the max array
float frequency;//the frequency in hertz
 
void setup()
{
  size(400, 200);
 
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.MONO, 4096, sampleRate);
  fft = new FFT(in.left.size(), sampleRate);
}
 
void draw()
{
 
  background(150);//black BG
 
  findNote(); //find note function
 
  textSize(50); //size of the text
 
  text (frequency-6+" hz", 50, 80);//display the frequency in hertz / Esto lo puso para calibrar la medida y que coincida por ej La(440Hz)
  pushStyle();
  fill(c);  //aquí está el COLORSH
  text ("note "+note, 50, 150);//display the note name
  popStyle();
}
 
void findNote() {
 
  fft.forward(in.left);
  for (int f=0;f<sampleRate/2;f++) { //analyses the amplitude of each frequency analysed, between 0 and 22050 hertz /*Setear a amplitud de voz humana
    max[f]=fft.getFreq(float(f)); //each index is correspondent to a frequency and contains the amplitude value 
  }
  maximum=max(max);//get the maximum value of the max array in order to find the PEACK DE VOLUMEN
 
  for (int i=0; i<max.length; i++) {// read each frequency in order to compare with the peak of volume
    if (max[i] == maximum) {//if the value is equal to the amplitude of the peak, get the index of the array, which corresponds to the frequency
      frequency= i;
    }
  }
 
 
  midi= 69+12*(log((frequency-6)/440));// formula that transform frequency to midi numbers
  n= int (midi);//cast to int
 
 
//the octave have 12 tones and semitones. So, if we get a modulo of 12, we get the note names independently of the frequency  
if (n%12==9)
  {
    note = ("a La");
    r = 255;
    g = 0;
    b = 0;
    c = color (r, g, b);
  }
 
  if (n%12==10)
  {
    note = ("a# La#");
    r = 255;
    g = 0;
    b = 80;
    c = color (r, g, b);
  }
 
  if (n%12==11)
  {
    note = ("b Si");
    r = 255;
    g = 0;
    b = 150;
    c = color (r, g, b);
  }
 
  if (n%12==0)
  {
    note = ("c Do");
    r = 200;
    g = 0;
    b = 255;
    c = color (r, g, b);
  }
 
  if (n%12==1)
  {
    note = ("c#  Do#");
    r = 100;
    g = 0;
    b = 255;
    c = color (r, g, b);
  }
 
  if (n%12==2)
  {
    note = ("d  Re");
    r = 0;
    g = 0;
    b = 255;
    c = color (r, g, b);
  }
 
  if (n%12==3)
  {
    note = ("d# Re#");
    r = 0;
    g = 50;
    b = 255;
    c = color (r, g, b);
  }
 
  if (n%12==4)
  {
    note = ("e Mi");
    r = 0;
    g = 150;
    b = 255;
    c = color (r, g, b);
  }
 
  if (n%12==5)
  {
    note = ("f Fa");
    r = 0;
    g = 255;
    b = 255;
    c = color (r, g, b);
  }
 
  if (n%12==6)
  {
    note = ("f# Fa#");
    r = 0;
    g = 255;
    b = 0;
    c = color (r, g, b);
  }
 
  if (n%12==7)
  {
    note = ("g Sol");
    r = 255;
    g = 255;
    b = 0;
    c = color (r, g, b);
  }
 
  if (n%12==8)
  {
    note = ("g# Sol#");
    r = 255;
    g = 150;
    b = 0;
    c = color (r, g, b);
  }
}
 
void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();
 
  super.stop();
}