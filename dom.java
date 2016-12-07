import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Janis
 */
public class Dom {

    public static void main(String[] args) {
        int board[][] = new int[8][8];
        int bestboard[][] = new int[8][8];

        //Play first move
        bestboard = find_pos(board,bestboard,1);
        for (int printi = 0; printi < 8; printi++) {
            for (int printj = 0; printj < 8; printj++) {
                System.out.print(bestboard[printi][printj] + " ");
            }
            System.out.println();
        }
        for (int printi = 0; printi < 8; printi++) {
            for (int printj = 0; printj <8; printj++) {
                board[printi][printj] = bestboard[printi][printj];
            }
        }

        //Play all the other moves
        int player = 2;

        for (int i=0; i<10;i++) {
            bestboard = find_pos(board, bestboard, player);

            for (int printi = 0; printi < 8; printi++) {
                for (int printj = 0; printj < 8; printj++) {
                    System.out.print(bestboard[printi][printj] + " ");
                }
                System.out.println();
            }
            for (int printi = 0; printi < 8; printi++) {
                for (int printj = 0; printj < 8; printj++) {
                    board[printi][printj] = bestboard[printi][printj];
                }
            }
            if (player==2) {player =1;} else {player=2;}
        }


    }

    //Method to place the domino stone on the board
    public static int[][] find_pos(int board[][], int bestboard[][],int given_player) {

        int vertical;
        int horizontal;
        int bestresult = 0;
        int maxvert =0 ;
        int maxhorz= 0;
        int bestvert = 0;
        int besthorz = 0;

        //Setting board restrictions
        if (given_player==1) {
            maxvert = 6;
            maxhorz = 7;
        }
        if (given_player==2) {
            maxvert = 7;
            maxhorz = 6;
        }

        //Determine the start position, 56 posibilites
        for (int startvertical = 0; startvertical <= maxvert; startvertical++) {
            outerloop:
            for (int starthorizontal = 0; starthorizontal <= maxhorz; starthorizontal++) {

                //set first move of player one


                    if (given_player == 1) {
                        if (board[startvertical][starthorizontal] == 0 && board[startvertical + 1][starthorizontal] == 0) {

                            board[startvertical][starthorizontal] = 1;
                            board[startvertical + 1][starthorizontal] = 1;
                        } else {
                            //go on to the next startposition
                            System.out.println("Break");
                            break outerloop;
                        }
                    }
                    if (given_player == 2) {
                        if (board[startvertical][starthorizontal] == 0 && board[startvertical][starthorizontal + 1] == 0) {

                            board[startvertical][starthorizontal] = 2;
                            board[startvertical][starthorizontal + 1] = 2;
                        } else {
                            //go on to the next startpositio
                            System.out.println("Break");
                            break outerloop;
                        }
                    }

                //count wins with this move
                int numberofwins = 0;

                //Play for each startposition 100 times
                for (int gameforstartpos=0;gameforstartpos<100;gameforstartpos++) {
                    //Next move
                    int Player = 0;
                    if (given_player==1) {Player = 2;}
                    if (given_player==2) {Player = 1;}

                    //Play the actual game
                    for (int actgame = 0; actgame < 10000; actgame++) {

                        if (Player == 2) {
                            //horizontal player
                            vertical = 0 + (int) (Math.random() * 6);
                            horizontal = 0 + (int) (Math.random() * 7);

                            if (board[vertical][horizontal] == 0 && board[vertical][horizontal+1] == 0) {
                                board[vertical][horizontal] = Player;
                                board[vertical][horizontal+1] = Player;

                                Player = 1;
                            }

                        }
                        if (Player == 1) {
                            //Vertical player
                            vertical = 0 + (int) (Math.random() * 7);
                            horizontal = 0 + (int) (Math.random() * 6);

                            if (board[vertical][horizontal] == 0 && board[vertical+1][horizontal] == 0) {
                                board[vertical][horizontal] = Player;
                                board[vertical+1][horizontal] = Player;

                                Player = 2;
                            }
                        }
                    }

                    for (int printi = 0; printi < 8; printi++) {
                        for (int printj = 0; printj < 8; printj++) {
                        }
                    }
                    if(Player == given_player){
                        numberofwins++;
                    }
                    int temp = 0;

                    for (int printi = 0; printi < 8; printi++) {

                        for (int printj = 0; printj <8; printj++) {
                            board[printi][printj] = bestboard[printi][printj];
                        }


                    }
                }
                System.out.println("With coordinates:"+startvertical+"-"+starthorizontal+" , the win percentage is:"+numberofwins);
                //Find out best move and write it in bestboard variable
                if (numberofwins > bestresult) {
                    bestresult = numberofwins;
                    besthorz = starthorizontal;
                    bestvert = startvertical;
                }

            }
        }
        if (given_player==1) {
            bestboard[bestvert][besthorz] = 1;
            bestboard[bestvert+1][besthorz] = 1;
        }
        if (given_player==2) {
            bestboard[bestvert][besthorz] = 2;
            bestboard[bestvert][besthorz+1] = 2;
        }
        return bestboard;
    }
}
