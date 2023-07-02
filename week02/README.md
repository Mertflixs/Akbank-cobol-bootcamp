# HOMEWORK 3

Bu ödevde VSAM dosyasından veri okuma ve bu verileri filtreleme işlemlerini yaptık.

```bash
  FILE-CONTROL.
           SELECT VSAM-FILE ASSIGN TO VSAMFILE
                            ORGANIZATION INDEXED
                            ACCESS RANDOM
                            RECORD KEY VSAM-KEY
                            STATUS ST-VSAM.
           SELECT OUT-FILE  ASSIGN TO OUTFILE
                            STATUS ST-OUT.
           SELECT INP-FILE  ASSIGN TO INPFILE
                            STATUS ST-INP.
```
normal dosya okumadan farklı olarak VSAM Dosyası okuma işleminde RECORD KEY özelliği, ACCESS özelliği, ve ORGANIZATION Özelliği Kullanılmıştır.
ORGANIZATION INDEXED ifadesi, anahtar alanlarına dayalı olarak kayıtlara erişim sağlayan veri yapısı olduğunu belirtir
ACCESS RANDOM ifadesi, dosyaya rastgele (random) erişimin yapılabileceğini belirtir.
RECORD KEY VSAM-KEY ifadesi, dosyadaki kayıtların erişiminde kullanılacak olan anahtar alanını belirtir. VSAM-KEY, dosyanın kayıtlarını benzersiz bir şekilde tanımlayan bir alanın adını temsil eder. Bu alan, dosyadaki kayıtların sıralanması ve erişimi için kullanılır.

```bash
  FILE SECTION.
       FD  VSAM-FILE.
         01  VSAM-REX.
           03 VSAM-KEY.
              05 VSAM-ID         PIC S9(5) COMP-3.
              05 VSAM-DVZ        PIC S9(3) COMP.
           03 VSAM-NAME          PIC X(30).
           03 VSAM-DATE          PIC S9(07) COMP-3.
           03 VSAM-BALANCE       PIC S9(15) COMP-3.
```
VSAM filedaki verilerin türlerine göre belirlenmiş programda kullanacağamız değişgenler.

Çalıştırma sıraması
```bash
  ilk önce SORTEG02.jcl dosyasını çalıştırıp QSAM dosyalarımızı oluşturuyoruz bu kısımda 2 tane dosyamız oluşucak 2. oluşan dosyamız(QSAM.BB) istenilen türlere çevrilmiş bir şekilde oluşucaktır.

  QSAM dosyalarımız oluştuktan sonra DELDEF01.jcl ile VSAM dosyamızı oluşturuyoruz. VScode ile bu dosyayı görüntüleyemeyiz bunun için MOCHA TN3270 kullanabiliriz.

  Son olarakda HMWRK03J.jcl dosyamızı çalıştırıyoruz input filedaki IDler ile filtreleyerek VSAM da olan IDleri .OUT uzantılı bir şekilde çıktı olarak veriyoruz.
```
