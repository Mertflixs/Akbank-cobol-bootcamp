//DELDEF01 JOB ' ',CLASS=A,MSGLEVEL=(1,1),
//         MSGCLASS=X,NOTIFY=&SYSUID
//DELET500 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
  DELETE Z95646.VSAM.EE CLUSTER PURGE
  IF LASTCC LE 08 THEN SET MAXCC = 00
        DEF CL ( NAME(Z95646.VSAM.EE)       -
                 FREESPACE( 20 20 )         -
                 SHR( 2,3 )                 -
                 KEYS(5 0)                  -
                 INDEXED SPEED              -
                 RECSZ(47 47)               -
                 TRK (10 10)                -
                 LOG(NONE)                  -
                 VOLUMES (VPWRKB)           -
                 UNIQUE )                   -
        DATA ( NAME(Z95646.VSAM.EE.DATA))   -
        INDEX ( NAME(Z95646.VSAM.EE.INDEX))
//REPRO600 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//INN001 DD DSN=Z95646.QSAM.BB,DISP=SHR
//OUT001 DD DSN=Z95646.VSAM.EE,DISP=SHR
//SYSIN DD *
   REPRO INFILE(INN001) OUTFILE(OUT001)