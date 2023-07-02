
# HOMEWORK 2

Bu ödevde QSAM file kullanarak bir sıralama işlemi yaptık ve doğum tarihini günümüz tarihinden ne kadar gün geçtiğini hesapladık.

PBEG005J.jcl Dosyasında bir liste oluşturuldu ve JCL sort özelliği kullanılarak sıralandı. Sıralanan liste UserID.QSAM.BB isimli bir dosyaya çıktı alındı.
Çıktı alındıktan sonra programımıza input file olarak verildi.

```bash
# Bu jcl dosyası ile girdilerimiz ile QSAM dosyalarımızı oluşturuyoruz.

//SORTREPR JOB ' ',CLASS=A,MSGLEVEL=(1,1),
//         MSGCLASS=X,NOTIFY=&SYSUID
//DELET100 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
   DELETE &SYSUID..QSAM.AA NONVSAM
   IF LASTCC LE 08 THEN SET MAXCC = 00
//SORT0200 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD *
0003MERT           ALASAHAN       19980717
0001HIKMET         ALASAHAN       19621010
0002NIHAL          ALASAHAN       19621010
0004SEVVAL         ALASAHAN       20090324
//SORTOUT  DD DSN=&SYSUID..QSAM.AA,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(5,5),RLSE),
//             DCB=(RECFM=FB,LRECL=42)
//SYSIN    DD *
    SORT FIELDS=COPY
//DELET300  EXEC PGM=IEFBR14
//FILE01    DD DSN=&SYSUID..QSAM.BB,
//             DISP=(MOD,DELETE,DELETE),SPACE=(TRK,0)
//SORT0400  EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*
//SORTIN    DD DSN=&SYSUID..QSAM.AA,DISP=SHR
//SORTOUT   DD DSN=&SYSUID..QSAM.BB,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(5,5),RLSE),
//             DCB=(RECFM=FB,LRECL=50)
//SYSIN     DD *
    SORT FIELDS=(1,4,CH,A)
    INCLUDE COND=(1,1,CH,EQ,C'0')
    OUTREC FIELDS=(1,42,DATE1)


```

```bash
  //RUN     EXEC PGM=PBEG005J
  //STEPLIB   DD DSN=&SYSUID..LOAD,DISP=SHR
  //DATEREC   DD DSN=&SYSUID..QSAM.BB,DISP=SHR
```
Bu PBEG005J.jcl dosyamızı çalıştırarak sıralanmış olan QSAM.BB dosyamızı okuyarak QSAM.CC dosyamızı oluşturduk. Bu dosyada BB den farklı olarak doğum gününden bu güne kadar kaç gün yaşadığını ekledik.

```bash
  //PRTLINE   DD DSN=&SYSUID..QSAM.CC,DISP=(NEW,CATLG,DELETE),
  //             SPACE=(TRK,(20,20),RLSE),
  //             DCB=(RECFM=FB,LRECL=58,BLKSIZE=0),
  //             UNIT=3390
  //SYSOUT    DD SYSOUT=*,OUTLIM=15000
```

COBOL dosyamızdaki tarih hesapladığımız kısım CALC-RECORD fonksiyonunda bulunmaktadır.

```bash
       CALC-RECORD.
           COMPUTE REC-DATE-INT = FUNCTION INTEGER-OF-DATE(REC-DATE)
           COMPUTE REC-NDATE-INT = FUNCTION INTEGER-OF-DATE(REC-NDATE)
           COMPUTE REC-LDAY = REC-NDATE-INT - REC-DATE-INT
           PERFORM WRITE-RECORD.
       CALC-END. EXIT.
```

COBOL programımızda dosya kontrolleri sağlanmıştır ve bu kontrollerle birlikte EOF(Dosya sonuna) gelene kadar QSAM.BB dosyamızdan okuma işlemi yapılmaktadır ve bu okuma işlemi ile birlikte yeni oluşucak QSAM.CC dosyamıza verilerimiz yazılmaktadır.

```bash
           OPEN INPUT  DATE-REC.
           OPEN OUTPUT PRINT-LINE.
           IF (ST-DATE-REC NOT = 0) AND (ST-DATE-REC NOT = 97)
           DISPLAY 'UNABLE TO OPEN INPFILE: ' ST-DATE-REC
           MOVE ST-DATE-REC TO RETURN-CODE
           PERFORM H999-PROGRAM-EXIT
           END-IF.
           IF (ST-PRINT-LINE NOT = 0) AND (ST-PRINT-LINE NOT = 97)
           DISPLAY 'UNABLE TO OPEN OUTFILE: ' ST-PRINT-LINE
           MOVE ST-PRINT-LINE TO RETURN-CODE
           PERFORM H999-PROGRAM-EXIT
           END-IF.
           READ DATE-REC.
           IF (ST-DATE-REC NOT = 0) AND (ST-DATE-REC NOT = 97)
           DISPLAY 'UNABLE TO READ INPFILE: ' ST-DATE-REC
           MOVE ST-DATE-REC TO RETURN-CODE
           PERFORM H999-PROGRAM-EXIT
           END-IF.
```

```bash
           WRITE-RECORD.
           MOVE REC-ID       TO  REC-ID-O.
           MOVE REC-NAME     TO  REC-NAME-O.
           MOVE REC-SRNAME   TO  REC-SRNAME-O.
           MOVE REC-DATE     TO  REC-DATE-O.
           MOVE REC-NDATE    TO  REC-NDATE-O.
           MOVE REC-LDAY     TO  REC-LDAY-O.
           WRITE PRINT-REC.
       WRITE-END. EXIT.
```
