package com.example.taskmaster1

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            MaterialTheme {
                GymTrackerApp()
            }
        }
    }
}

@Composable
fun GymTrackerApp() {

    var ejercicio by remember { mutableStateOf("") }
    var series by remember { mutableStateOf("") }
    var peso by remember { mutableStateOf("") }

    val listaEjercicios = remember {
        mutableStateListOf<String>()
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {

        Text(
            text = "Gym Tracker DevSecOps",
            style = MaterialTheme.typography.headlineMedium

        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Ejercicios registrados: ${listaEjercicios.size}"
        )

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedTextField(
            value = ejercicio,
            onValueChange = { ejercicio = it },
            label = { Text("Nombre del ejercicio") },
            modifier = Modifier.fillMaxWidth()
        )

        Spacer(modifier = Modifier.height(8.dp))

        OutlinedTextField(
            value = series,
            onValueChange = { series = it },
            label = { Text("Series x Repeticiones") },
            modifier = Modifier.fillMaxWidth()
        )

        Spacer(modifier = Modifier.height(8.dp))

        OutlinedTextField(
            value = peso,
            onValueChange = { peso = it },
            label = { Text("Peso en kg") },
            modifier = Modifier.fillMaxWidth()
        )

        Spacer(modifier = Modifier.height(12.dp))

        Button(
            onClick = {

                if (
                    ejercicio.isNotBlank() &&
                    series.isNotBlank() &&
                    peso.isNotBlank()
                ) {

                    listaEjercicios.add(
                        "🏋️ $ejercicio\n📊 $series\n⚖️ $peso kg"
                    )

                    ejercicio = ""
                    series = ""
                    peso = ""
                }
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Agregar ejercicio")
        }

        Spacer(modifier = Modifier.height(20.dp))

        LazyColumn {

            itemsIndexed(listaEjercicios) { index, item ->

                Card(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 5.dp)
                ) {

                    Column(
                        modifier = Modifier.padding(12.dp)
                    ) {

                        Text(item)

                        Spacer(modifier = Modifier.height(8.dp))

                        Button(
                            onClick = {
                                listaEjercicios.removeAt(index)
                            }
                        ) {
                            Text("Eliminar")
                        }
                    }
                }
            }
        }
    }
}
