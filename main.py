import speech_recognition as sr
import pyttsx3
import time
import cv2
import threading 
# 3.13

bandera_escuchando = False
bandera_conectar = False

def hablar(mensaje):
        engine = pyttsx3.init()
        engine.setProperty('rate', 140) 
        engine.say(mensaje)
        engine.runAndWait()
   
def llamada(cap):
    print(" LLAMADA CONECTADA")
    print(" Presiona 'f' para colgar.")
    
    start_time = time.time()

    while True:
        ret, frame = cap.read()
        if not ret: break

        cv2.rectangle(frame, (0, 0), (640, 80), (0, 0, 200), -1)
        cv2.putText(frame, "EN LLAMADA - SEGURIDAD", (20, 40), 
                    cv2.FONT_HERSHEY_SIMPLEX, 0.8, (255, 255, 255), 2)
        
        tiempo_actual = int(time.time() - start_time)
        minutos = tiempo_actual // 60
        segundos = tiempo_actual % 60
        texto_tiempo = f"Duracion: {minutos:02d}:{segundos:02d}"
        
        cv2.putText(frame, texto_tiempo, (20, 70), 
                    cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 255, 255), 1)
        
        cv2.putText(frame, "[Presiona 'f' para Colgar]", (380, 70), 
            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (200, 200, 200), 1)

        cv2.imshow('Totem Vision', frame)

        key = cv2.waitKey(1) & 0xFF
        if key == ord('f'):
            print("Llamada finalizada manualmente.")
            hablar("Llamada finalizada. Gracias.")
            print("Regresando a modo vigilancia")
            break

def escuchando():
    global bandera_escuchando, bandera_conectar
    
    recognizer = sr.Recognizer()
    hablar("Bienvenido. Para comunicarte con seguridad. Por favor, di hola.")
    
    with sr.Microphone() as source:
        print("\n" + "="*30)
        print(" ESCUCHANDO ")
        print("="*30 + "\n")
        recognizer.adjust_for_ambient_noise(source, duration=1)
        audio = recognizer.listen(source, timeout=5)
    try: 
        print(">>> Reconociendo...")
        text = recognizer.recognize_google(audio, language="es-ES")
        print(f">>> Dijiste: '{text}'")
            
        if "hola" in text.lower():
            print("Comando aceptado")
            hablar("Entendido. Conectando llamada.")
            bandera_conectar = True 
            time.sleep(2)

    except sr.WaitTimeoutError:
        print("Tiempo agotado: Nadie habló.")
        
    except Exception as e:
        print(f">>> Error técnico: {e}")
        
    finally:
        bandera_escuchando = False

def propuesta_camara():
    global bandera_escuchando, bandera_conectar

    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    cap = cv2.VideoCapture(0)
    
    cv2.namedWindow('Totem Vision', cv2.WND_PROP_FULLSCREEN)
    cv2.setWindowProperty('Totem Vision', cv2.WND_PROP_FULLSCREEN, cv2.WINDOW_FULLSCREEN)

    print("SISTEMA LISTO.")
    
    tiempo_inicio_deteccion = 0
    TIEMPO_NECESARIO = 0.5  

    while True:
        ret, frame = cap.read()
        if not ret: break

        if bandera_conectar:
            llamada(cap) 
            bandera_conectar = False 
            tiempo_inicio_deteccion = 0 
            time.sleep(2) 

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(gray, 1.1, 5, minSize=(60, 60))

        if len(faces) > 0 and not bandera_escuchando:
            if tiempo_inicio_deteccion == 0:
                tiempo_inicio_deteccion = time.time() 
            
            tiempo_transcurrido = time.time() - tiempo_inicio_deteccion
            
            for (x, y, w, h) in faces:
                cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
                
                progreso = int((tiempo_transcurrido / TIEMPO_NECESARIO) * w)
                if progreso > w: progreso = w
                cv2.rectangle(frame, (x, y-10), (x+progreso, y-5), (0, 255, 0), -1)

            if tiempo_transcurrido >= TIEMPO_NECESARIO:
                bandera_escuchando = True
                tiempo_inicio_deteccion = 0 
                hilo = threading.Thread(target=escuchando)
                hilo.start()
        
        else:
            if not bandera_escuchando:
                tiempo_inicio_deteccion = 0

        cv2.imshow('Totem Vision', frame)

        key = cv2.waitKey(1) & 0xFF
        if key == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    propuesta_camara()
