public class Lab1 {

    public static void main(String[] args) {

        // rader som denna är kommentarer

        // vi deklarar en array som heter a
        int[] a = { 21, 19, 3,  15, 53, 33, 239, 233, 14, 97,
                9,  8,  45, 35, 73, 55, 731,  81, 51, 49 };

        // skriver ut en hälsning och sedan element 1 av array a (dvs värdet 19)
        System.out.println("Hello!");
        System.out.println(a[1]);

        // lösning för del 1
        System.out.println("Del 1:");
        // din kod här
        for(int i=0;i<a.length;i++){
            System.out.print(a[i]+" ");
        }
        System.out.print("\n");




        // lösning för del 2
        System.out.println("Del 2:");
        // din kod här
        int biggestNr=0;
        for(int i=0;i<a.length;i++){
            if(a[i]>biggestNr){biggestNr = a[i];}
        }
        System.out.println(biggestNr);


        // lösning för del 3
        System.out.println("Del 3:");
        // din kod här
        int sumEvenNr=0;
        for(int i=0;i<a.length;i++){
            if(a[i]%2==0){sumEvenNr +=a[i];}
        }
        for(int i=0;i<a.length;i++){
            if(a[i]>sumEvenNr){System.out.print(a[i]+" ");}
        }
        System.out.print("\n");
        // frivilligt: lösning för del 4
        System.out.println("Del 4:");
        // din kod här



    }

}