# HOMEWORK 1

Bu ödevde hatalı olan HMWRK00J.jcl dosyamızı düzenleyip çalışır hale getirdik.



PRTLINE kısmındaki düzenleme ile programımızın çıktısı .OUTPUT uzantılı bir şekilde oluşturması sağlanmıştır.

```bash
  //PRTLINE   DD DSN=&SYSUID..HMWRK00.OUTPUT,DISP=(NEW,CATLG,DELETE),
  //            SPACE=(CYL,(10,5),RLSE)
```

```bash
  DISP=(NEW,CATLG,DELETE)
```

DISP, veri setinin nasıl işlenmesi gerektiğini belirtir.

NEW, veri setinin yeni oluşturulacağını ifade eder. Eğer veri seti zaten varsa hata oluşur.

CATLG, veri setinin kataloglanacağını ifade eder. Bu sayede veri seti, katalogda bulunabilir ve erişilebilir olur.

DELETE, veri setinin işlem tamamlandıktan sonra silineceğini belirtir. Bu sayede gereksiz veri setleri temizlenir.

```bash
  SPACE=(CYL,(10,5),RLSE)
```

SPACE, veri setinin fiziksel depolama alanını belirler.

CYL, veri setinin silindirlerle ölçülerek alan ayrılacağını ifade eder. Silindirler, disk üzerindeki birimlerdir.

(10,5), veri setinin ayrılacak silindir sayısını ve bir silindirin içerisindeki blok sayısını belirtir. Bu örnekte, 10 silindir ve her bir silindirde 5 blok ayrılacak demektir.

RLSE, veri setinin kullanılmadığında (tamamlandığında veya silindiğinde) bu alanın serbest bırakılacağını ifade eder. Böylece kullanılmayan alanlar başka amaçlar için kullanılabilir hale gelir.

