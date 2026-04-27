<<<<<<< Updated upstream
hola
=======
# Predicción de Supervivencia en el Titanic - Machine Learning

## 📋 Descripción del Proyecto

Este proyecto implementa un análisis completo del conjunto de datos del Titanic usando técnicas de Machine Learning. El objetivo es desarrollar modelos predictivos capaces de determinar si un pasajero sobrevivió al hundimiento del Titanic basándose en características como edad, sexo, clase de pasajero, entre otros.

El proyecto demuestra todo el flujo de trabajo de ciencia de datos:
- **Carga y exploración de datos**
- **Preprocesamiento y limpieza de datos**
- **Transformación de características**
- **Entrenamiento de múltiples modelos**
- **Evaluación y comparación de rendimiento**
- **Generación de predicciones**

---

## 🎯 Objetivo

Desarrollar un modelo de clasificación que prediga con precisión si un pasajero del Titanic sobrevivió al desastre. Se utilizan múltiples algoritmos de Machine Learning para comparar su rendimiento y seleccionar el más adecuado.

---

## 📊 Datasets Utilizados

### Archivos de entrada:
- `train.csv` - Datos de entrenamiento (891 pasajeros) con información de supervivencia
- `test.csv` - Datos de prueba (418 pasajeros) sin información de supervivencia
- `gender_submission.csv` - Archivo de referencia para las predicciones

### Características principales:
- **PassengerId**: Identificador único del pasajero
- **Survived**: Indicador de supervivencia (0 = No sobrevivió, 1 = Sobrevivió)
- **Pclass**: Clase del pasajero (1ª, 2ª, 3ª clase)
- **Sex**: Sexo del pasajero
- **Age**: Edad del pasajero
- **SibSp**: Número de hermanos/cónyuge a bordo
- **Parch**: Número de padres/hijos a bordo
- **Fare**: Tarifa pagada
- **Embarked**: Puerto de embarque (C = Cherburgo, Q = Queenstown, S = Southampton)

---

## 🔧 Procesamiento de Datos

### 1. Carga de datos
Se cargan los conjuntos de entrenamiento usando pandas.

### 2. Análisis de valores faltantes
```
Valores faltantes detectados:
- Age: 177 valores faltantes
- Cabin: 687 valores faltantes
- Embarked: 2 valores faltantes
```

### 3. Mapa de calor de valores faltantes
![Heatmap de valores faltantes](https://via.placeholder.com/600x400?text=Heatmap+de+Valores+Faltantes)

**Explicación**: Este gráfico visualiza la distribución de valores faltantes en el conjunto de datos. Las áreas oscuras representan datos ausentes, permitiendo identificar rápidamente qué columnas tienen más valores vacíos. En este caso, la columna "Cabin" tiene la mayoría de valores faltantes.

### 4. Tratamiento de valores faltantes
- **Age**: Rellena con 0 (usando media o mediana sería más apropiado en un análisis real)
- **Cabin**: Eliminada por tener demasiados valores faltantes
- **Embarked**: Rellena con el valor más frecuente

### 5. Codificación de variables categóricas
- **Sex**: Convertida a valores numéricos (female=0, male=1)
- **Embarked**: Convertida a variables binarias (one-hot encoding)
  - Embarked_S, Embarked_Q, Embarked_C

### 6. Eliminación de características
Se eliminan las siguientes columnas por no ser necesarias:
- Name, PassengerId, Ticket, Cabin, Embarked (original), Sex (original)

---

## 🧪 División de Datos

Los datos se dividen en:
- **Entrenamiento (66%)**: 591 muestras
- **Prueba (34%)**: 277 muestras

La división se realiza de forma aleatoria para garantizar una evaluación objetiva del modelo.

---

## 🔬 Transformación de Características

Se utiliza `ColumnTransformer` para aplicar diferentes transformaciones:

### Técnicas aplicadas:
1. **StandardScaler** (7 columnas): Normaliza características numéricas a media=0, desviación=1
   - Columnas: Pclass, SibSp, Parch, Fare, Embarked_S, Embarked_Q, Embarked_C

2. **KBinsDiscretizer** (1 columna): Divide una característica en intervalos discretos
   - Columna: Age (convertida en bins)

---

## 🤖 Modelos Entrenados

### Modelo 1: K-Nearest Neighbors (KNN)
**Descripción**: Algoritmo que clasifica un punto basándose en sus k vecinos más cercanos.

**Parámetros**:
- n_neighbors = 9
- Métrica de distancia: Euclidiana (por defecto)

**Rendimiento**:
- **Precisión en datos de prueba: 71.29%**
- Matriz de confusión:

![Matriz de Confusión - KNN](https://via.placeholder.com/600x400?text=Matriz+de+Confusion+KNN)

**Explicación de la matriz**: Muestra el rendimiento del modelo KNN en los datos de prueba. Los verdaderos negativos (arriba a la izquierda) y verdaderos positivos (abajo a la derecha) muestran predicciones correctas, mientras que los falsos positivos y falsos negativos muestran errores del modelo.

---

### Modelo 2: Regresión Logística
**Descripción**: Modelo lineal que usa función logística para clasificación binaria.

**Parámetros**:
- solver = 'liblinear'
- Regularización L2 (por defecto)

**Rendimiento**:
- **Precisión en datos de prueba: 70.96%**
- Mejor rendimiento en identificación de patrones lineales

---

## ⚖️ Balanceo de Clases

El conjunto de datos original es desbalanceado:
```
Clase 0 (No sobrevivió): 549 muestras (61.6%)
Clase 1 (Sobrevivió): 342 muestras (38.4%)
```

![Distribución de Supervivencia](https://via.placeholder.com/600x400?text=Distribucion+de+Supervivencia)

**Explicación**: Este gráfico de barras muestra la distribución desigual de clases. Hay muchos más pasajeros que no sobrevivieron que pasajeros que sobrevivieron. Para tratar este desbalance, se aplicó SMOTE (Synthetic Minority Over-sampling Technique) en el segundo modelo.

### Técnicas aplicadas:
1. **RandomOverSampler**: Duplica muestras de la clase minoritaria
   - Resultado: 549 muestras en cada clase

2. **SMOTE**: Genera muestras sintéticas interpolando entre puntos de la clase minoritaria
   - Resultado: Distribución balanceada con datos sintéticos

---

## 📈 Modelo con Balanceo (SMOTE)

**Descripción**: KNN combinado con SMOTE para mejorar el rendimiento.

**Pipeline**:
1. Transformación de características (ColumnTransformer)
2. Generación de muestras sintéticas (SMOTE)
3. Clasificación con KNN

**Rendimiento**:
- **Precisión en datos de prueba: 66.99%**
- Nota: La precisión disminuye pero el modelo es más robusto a nuevos datos

---

## 🎯 Resultados Finales

### Comparación de Modelos:

| Modelo | Precisión | Observaciones |
|--------|-----------|---------------|
| K-Nearest Neighbors (KNN) | 71.29% | Mejor rendimiento general |
| Regresión Logística | 70.96% | Buena generalización |
| KNN con SMOTE | 66.99% | Mayor robustez |

### Predicciones:
El modelo de Regresión Logística se utilizó para generar predicciones en el conjunto de prueba:
- Muestras predichas como sobrevivientes: 126
- Muestras predichas como no sobrevivientes: 292

---

## 📁 Archivos de Salida

- `submission.csv` - Archivo con las predicciones finales en formato requerido por Kaggle
  - Columnas: PassengerId, Survived
  - Formato: 419 filas (1 encabezado + 418 predicciones)

---

## 🛠️ Herramientas y Librerías Utilizadas

```python
# Procesamiento de datos
import pandas as pd
import numpy as np

# Visualización
```

## Instalación y ejecución (Windows y Linux)

- **Instalar dependencias:** crea y activa un entorno virtual y luego instala:

   - Linux/macOS:

      ```bash
      python3 -m venv .venv
      source .venv/bin/activate
      python -m pip install --upgrade pip
      pip install -r requirements.txt
      ```

   - Windows (PowerShell / CMD):

      ```powershell
      python -m venv .venv
      .venv\Scripts\activate
      python -m pip install --upgrade pip
      pip install -r requirements.txt
      ```

- **Abrir el notebook:**

   - Ejecuta en Linux/macOS: `./run.sh` (da permisos con `chmod +x run.sh` si hace falta)
   - Ejecuta en Windows: `run.bat`

Los paquetes listados en `requirements.txt` cubren las importaciones usadas en `titanic.ipynb`.
import seaborn as sns
import matplotlib.pyplot as plt

# Machine Learning
from sklearn.preprocessing import StandardScaler, KBinsDiscretizer, Binarizer
from sklearn.compose import make_column_transformer
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, ConfusionMatrixDisplay

# Desbalance de clases
from imblearn.over_sampling import RandomOverSampler, SMOTE
from imblearn.pipeline import make_pipeline
```

---

## 📝 Conclusiones

1. **KNN es el mejor modelo** con una precisión del 71.29%, demostrando que la estructura local de datos es útil para esta predicción.

2. **Regresión Logística es comparable** con 70.96%, indicando que hay relaciones lineales significativas en los datos.

3. **SMOTE reduce precisión pero mejora robustez**, por lo que es útil cuando la generalización es crítica.

4. **Las características más importantes** parecen ser el sexo, la clase y la tarifa pagada, según estudios previos del Titanic.

5. **Oportunidades de mejora**:
   - Mejor tratamiento de valores faltantes (usar media/mediana)
   - Feature engineering adicional (agrupar familias, crear características derivadas)
   - Tunning de hiperparámetros
   - Ensemble de modelos
   - Validación cruzada para evaluar estabilidad

---

## 🔗 Referencias

- Dataset: [Titanic - Machine Learning from Disaster](https://www.kaggle.com/c/titanic)
- Documentación de scikit-learn: https://scikit-learn.org/
- Documentación de imbalanced-learn: https://imbalanced-learn.org/

---

**Autor**: Análisis del Titanic - Clase Final de Tratamiento de Datos  
**Fecha**: 2026  
**Estado**: Completado exitosamente
>>>>>>> Stashed changes
