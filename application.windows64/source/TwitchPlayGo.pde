import org.jibble.pircbot.*;

TwitchGoBot bot;
Button resetButton;

String username;
String password;
String channel;
String irc;
String port;

class TwitchGoBot extends PircBot {
  
  int[] goban;
  String[] points= {"a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15","a16","a17","a18","a19",
                    "b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","b14","b15","b16","b17","b18","b19",
                    "c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13","c14","c15","c16","c17","c18","c19",
                    "d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","d11","d12","d13","d14","d15","d16","d17","d18","d19",
                    "e1","e2","e3","e4","e5","e6","e7","e8","e9","e10","e11","e12","e13","e14","e15","e16","e17","e18","e19",
                    "f1","f2","f3","f4","f5","f6","f7","f8","f9","f10","f11","f12","f13","f14","f15","f16","f17","f18","f19",
                    "g1","g2","g3","g4","g5","g6","g7","g8","g9","g10","g11","g12","g13","g14","g15","g16","g17","g18","g19",
                    "h1","h2","h3","h4","h5","h6","h7","h8","h9","h10","h11","h12","h13","h14","h15","h16","h17","h18","h19",
                    "i1","i2","i3","i4","i5","i6","i7","i8","i9","i10","i11","i12","i13","i14","i15","i16","i17","i18","i19",
                    "j1","j2","j3","j4","j5","j6","j7","j8","j9","j10","j11","j12","j13","j14","j15","j16","j17","j18","j19",
                    "k1","k2","k3","k4","k5","k6","k7","k8","k9","k10","k11","k12","k13","k14","k15","k16","k17","k18","k19",
                    "l1","l2","l3","l4","l5","l6","l7","l8","l9","l10","l11","l12","l13","l14","l15","l16","l17","l18","l19",
                    "m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12","m13","m14","m15","m16","m17","m18","m19",
                    "n1","n2","n3","n4","n5","n6","n7","n8","n9","n10","n11","n12","n13","n14","n15","n16","n17","n18","n19",
                    "o1","o2","o3","o4","o5","o6","o7","o8","o9","o10","o11","o12","o13","o14","o15","o16","o17","o18","o19",
                    "p1","p2","p3","p4","p5","p6","p7","p8","p9","p10","p11","p12","p13","p14","p15","p16","p17","p18","p19",
                    "q1","q2","q3","q4","q5","q6","q7","q8","q9","q10","q11","q12","q13","q14","q15","q16","q17","q18","q19",
                    "r1","r2","r3","r4","r5","r6","r7","r8","r9","r10","r11","r12","r13","r14","r15","r16","r17","r18","r19",
                    "s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11","s12","s13","s14","s15","s16","s17","s18","s19",
                    "t1","t2","t3","t4","t5","t6","t7","t8","t9","t10","t11","t12","t13","t14","t15","t16","t17","t18","t19",
 };
 
 ArrayList<String> votedUsers = new ArrayList<String>();
  
  TwitchGoBot() {
        String[] lines = loadStrings("settings.txt");
        
        username = lines[0].replaceAll("username: ","");
        password = lines[1].replaceAll("password: ","");
        channel = lines[2].replaceAll("channel: ","");
        irc = lines[3].replaceAll("irc: ","");
        port = lines[4].replaceAll("port: ","");
       
        this.setName(username);
        int intersections = 20*20;
        goban = new int[intersections];
    }
    
    public void onMessage(String channel, String sender, String login, String hostname, String message) {
      String msg;
      msg = message.replaceAll("!","");
      
      if (msg.length() <= 3)
      if (!votedUsers.contains(sender))
      for (int i = 0; i < points.length; i++){
        if (msg.equalsIgnoreCase(points[i])) {
            goban[i]++;
            votedUsers.add(sender);
       }
      }
    }
    
    public void showVotes(){
      String topThree[] = {"???", "???", "???"};
      int topThreeVotes[] = new int[3];
      
      for (int i = 0; i<goban.length;i++){
        if (goban[i] > topThreeVotes[0]){
          
          topThreeVotes[2] = topThreeVotes[1];
          topThree[2] = topThree[1];
          
          topThreeVotes[1] = topThreeVotes[0];
          topThree[1] = topThree[0];
          
          topThreeVotes[0] = goban[i];
          topThree[0] = points[i];
        } else if (goban[i] > topThreeVotes[1]){
          topThreeVotes[2] = topThreeVotes[1];
          topThree[2] = topThree[1];
          
          topThreeVotes[1] = goban[i];
          topThree[1] = points[i];
        } else if (goban[i] > topThreeVotes[2]){
          topThreeVotes[2] = goban[i];
          topThree[2] = points[i];
        }
      }
      
      fill(255);
      text(topThree[0] + " " + topThreeVotes[0],10,textAscent()*1+textAscent()/3*1);
      text(topThree[1] + " " + topThreeVotes[1],10,textAscent()*2+textAscent()/3*2);
      text(topThree[2] + " " + topThreeVotes[2],10,textAscent()*3+textAscent()/3*3);
      
    }
    
    public void reset(){
      int intersections = 19*19;
      goban = new int[intersections];
      votedUsers = new ArrayList<String>();
    }
}

void setup()
{
    size(200,150);
    textSize(32);
    
    surface.setAlwaysOnTop(true);
    
    resetButton = new Button(10,100);
 
     // Now start our bot up.
    bot = new TwitchGoBot();
 
    // Enable debugging output.
    bot.setVerbose(false);
 
    // Connect to the IRC server.
    try{
    bot.connect(irc, Integer.parseInt(port), password);
    }catch(Exception e){
      e.printStackTrace();
      System.exit(-1);
    }  
 
    // Join the #pircbot channel.
    bot.joinChannel(channel);
}
 
void draw()
{
  background(0);
  bot.showVotes();
  resetButton.update();
  resetButton.render();
}