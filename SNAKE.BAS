DECLARE SUB food ()


delay = 2000

sz = 10
x = 0
y = 0
dx = 1
dy = 0

cols = 32
rows = 20
n = cols * rows

sn = 4

DIM sx(1 TO n), sy(1 TO n)

fx = 0
fy = 0

blink = 0
blinkMax = 2000



SCREEN 13

LINE (0, 0)-(319, 199), 1, BF

CALL food

DO
      
        FOR i = sn TO 2 STEP -1
                sx(i) = sx(i - 1)
                sy(i) = sy(i - 1)
        NEXT

        sx(1) = x
        sy(1) = y

        LINE (x * sz, y * sz)-(x * sz + sz - 1, y * sz + sz - 1), 14, BF
      
        FOR d = 0 TO delay
       
                blink = blink + 1
                IF blink < blinkMax / 2 THEN
                        LINE (fx * sz, fy * sz)-(fx * sz + sz - 1, fy * sz + sz - 1), 14, BF
                ELSEIF blink < blinkMax THEN
                        LINE (fx * sz, fy * sz)-(fx * sz + sz - 1, fy * sz + sz - 1), 1, BF
                ELSE
                        blink = 0
                END IF
               
               
                k$ = INKEY$
                IF k$ <> "" THEN EXIT FOR
        NEXT


        LINE (sx(sn) * sz, sy(sn) * sz)-(sx(sn) * sz + sz - 1, sy(sn) * sz + sz - 1), 1, BF
       
        IF k$ <> "" THEN

                SELECT CASE k$
                        CASE CHR$(27)
                                EXIT DO
                        CASE "w"
                                IF dy <> 1 THEN
                                        dx = 0
                                        dy = -1
                                END IF
                        CASE "s"
                                IF dy <> -1 THEN
                                        dx = 0
                                        dy = 1
                                END IF
                        CASE "a"
                                IF dx <> 1 THEN
                                        dx = -1
                                        dy = 0
                                END IF
                        CASE "d"
                                IF dx <> -1 THEN
                                        dx = 1
                                        dy = 0
                                END IF
                END SELECT
      
        END IF

        x = x + dx
        y = y + dy
                      
        IF x < 0 THEN x = cols - 1
        IF y < 0 THEN y = rows - 1
        IF x > cols - 1 THEN x = 0
        IF y > rows - 1 THEN y = 0

        FOR i = 1 TO sn
                IF x = sx(i) AND y = sy(i) THEN
                        EXIT DO
                END IF
        NEXT

        IF x = fx AND y = fy THEN
                sn = sn + 1
                IF sn = n THEN EXIT DO
                food
        END IF


LOOP

SUB food
        SHARED cols, rows, fx, fy, sn, sx(), sy()

        fx = INT(RND * cols)
        fy = INT(RND * rows)

        DO
               
                again = 0

                FOR i = 1 TO sn
                        IF sx(i) = fx AND sy(i) = fy THEN
                                again = 1
                        END IF
                NEXT

                IF again = 1 THEN
                        fx = fx + 1
                        IF fx >= cols THEN
                                fx = 0
                                fy = fy + 1
                                IF fy >= rows THEN fy = 0
                        END IF
                END IF

        LOOP WHILE again = 1

END SUB

