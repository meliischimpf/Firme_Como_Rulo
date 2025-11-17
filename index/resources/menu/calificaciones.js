// Function to save a single grade
function guardarNota(input) {
    const row = input.closest('tr');
    const alumnoId = input.name.match(/notas\[(\d+)\].*?\[(\w+)\]/)[1];
    const tipoNota = input.name.match(/\[(\w+)\]$/)[1];
    
    // Get all grade inputs for this student
    const parcial1Input = row.querySelector('input[name$="[parcial1]"]');
    const parcial2Input = row.querySelector('input[name$="[parcial2]"]');
    const finalInput = row.querySelector('input[name$="[final]"]');
    
    const data = {
        id_materia: document.querySelector('input[name="id_materia"]').value,
        notas: {
            [alumnoId]: {
                parcial1: parcial1Input.value ? parseFloat(parcial1Input.value) : null,
                parcial2: parcial2Input.value ? parseFloat(parcial2Input.value) : null,
                final: finalInput.value ? parseFloat(finalInput.value) : null
            }
        }
    };
    
    if (tipoNota === 'parcial1' || tipoNota === 'parcial2') {
        calcularPromedio(input);
    }
    
    guardarCalificacion(input, data);
}

// Función para calcular el promedio
function calcularPromedio(input) {
    const row = input.closest('tr');
    const parcial1 = parseFloat(row.querySelector('input[name$="[parcial1]"]').value) || 0;
    const parcial2 = parseFloat(row.querySelector('input[name$="[parcial2]"]').value) || 0;
    const promedio = (parcial1 + parcial2) / 2;
    
    const promedioCell = row.querySelector('.promedio');
    if (promedioCell) {
        promedioCell.textContent = promedio.toFixed(1);
        promedioCell.className = 'grade-badge promedio ' + getGradeClass(promedio);
    }
}

// Función para obtener la clase CSS según la nota
function getGradeClass(grade) {
    if (!grade && grade !== 0) return '';
    if (grade >= 9) return 'grade-a';
    if (grade >= 7) return 'grade-b';
    if (grade >= 5) return 'grade-c';
    if (grade >= 4) return 'grade-d';
    return 'grade-f';
}

// Función para crear el indicador de guardado
function createSaveIndicator() {
    const indicator = document.createElement('div');
    indicator.className = 'save-indicator';
    indicator.style.position = 'fixed';
    indicator.style.bottom = '20px';
    indicator.style.right = '20px';
    indicator.style.padding = '12px 24px';
    indicator.style.background = 'var(--primary-color)';
    indicator.style.color = 'white';
    indicator.style.borderRadius = '4px';
    indicator.style.boxShadow = '0 2px 10px rgba(0,0,0,0.2)';
    indicator.style.display = 'none';
    indicator.style.zIndex = '1000';
    indicator.style.transition = 'all 0.3s ease';
    document.body.appendChild(indicator);
    return indicator;
}

// Función para actualizar el indicador
function updateSaveIndicator(indicator, text, color) {
    indicator.textContent = text;
    indicator.style.background = color;
    indicator.style.display = 'block';
    
    // Ocultar el indicador después de un tiempo
    const delay = color === '#F44336' ? 4000 : 2000;
    setTimeout(() => {
        indicator.style.opacity = '0';
        setTimeout(() => {
            indicator.style.display = 'none';
            indicator.style.opacity = '1';
        }, 300);
    }, delay);
}

function formatFormData(form) {
    console.log('Buscando filas de estudiantes...');
    const data = {
        id_materia: form.querySelector('input[name="id_materia"]')?.value,
        notas: {}
    };

    // Buscar filas de estudiantes
    const rows = form.querySelectorAll('table.grade-table tbody tr.student-row');
    console.log(`Se encontraron ${rows.length} filas de estudiantes`);

    if (rows.length === 0) {
        console.warn('No se encontraron filas de estudiantes en la tabla');
        console.log('Contenido del formulario:', form.innerHTML);
        return data;
    }

    rows.forEach(row => {
        // Obtener el ID del alumno del primer input de nota
        const input = row.querySelector('input[type="number"]');
        if (!input) {
            console.warn('Fila sin inputs de nota');
            return;
        }

        // Extraer el ID del alumno del nombre del input
        const nameAttr = input.getAttribute('name');
        const match = nameAttr.match(/notas\[(\d+)\]/);
        
        if (!match || !match[1]) {
            console.warn('No se pudo extraer el ID del alumno del input:', nameAttr);
            return;
        }

        const alumnoId = match[1];
        console.log(`Procesando alumno ID: ${alumnoId}`);

        // Obtener los inputs de la fila actual
        const inputs = {
            parcial1: row.querySelector('input[name^="notas["][name$="[parcial1]"]'),
            parcial2: row.querySelector('input[name^="notas["][name$="[parcial2]"]'),
            final: row.querySelector('input[name^="notas["][name$="[final]"]')
        };

        // Verificar que los inputs existen
        if (!inputs.parcial1 || !inputs.parcial2 || !inputs.final) {
            console.warn(`Faltan inputs para el alumno ${alumnoId}`);
            return;
        }

        // Crear objeto de notas para el alumno actual
        const notasAlumno = {};
        
        // Procesar cada nota
        Object.entries(inputs).forEach(([key, input]) => {
            const valor = input.value.trim();
            // Convertir a número si tiene valor, de lo contrario null
            notasAlumno[key] = valor !== '' ? parseFloat(valor) : null;
        });

        // Verificar que al menos una nota tenga valor
        if (Object.values(notasAlumno).some(valor => valor !== null)) {
            data.notas[alumnoId] = notasAlumno;
        } else {
            console.warn(`Todas las notas están vacías para el alumno ${alumnoId}`);
        }
    });
    
    console.log('Datos formateados:', JSON.stringify(data, null, 2));
    return data;
}

// Función para guardar las calificaciones
function guardarCalificacion(input, data) {
    const saveIndicator = document.querySelector('.save-indicator') || createSaveIndicator();
    updateSaveIndicator(saveIndicator, 'Guardando...', 'var(--primary-color)');
    
    const baseUrl = window.location.origin + window.location.pathname.split('/').slice(0, -3).join('/');
    const url = new URL('index/menu/ingresar/guardar_calificaciones.php', baseUrl).toString();
    
    // Log the data being sent
    console.log('Enviando datos a:', url);
    console.log('Datos enviados:', data);
    
    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'Accept': 'application/json'
        },
        credentials: 'same-origin',
        body: JSON.stringify(data)
    })
    .then(async response => {
        const responseText = await response.text();
        console.log('Respuesta del servidor:', responseText);
        
        let jsonResponse;
        try {
            jsonResponse = JSON.parse(responseText);
        } catch (e) {
            // If it's not JSON, it's probably an HTML error page
            console.error('La respuesta no es JSON válido. Respuesta recibida:', responseText);
            
            // Try to extract error message from HTML if possible
            const errorMatch = responseText.match(/<b>(Fatal|Parse) error<\/b>:\s*(.*?)<br\s*\/>/i);
            const errorMessage = errorMatch ? 
                `Error del servidor: ${errorMatch[2]}` : 
                'El servidor devolvió una respuesta inesperada';
                
            throw new Error(errorMessage);
        }
        
        if (!response.ok) {
            const errorMessage = jsonResponse.message || 
                               (jsonResponse.error || 'Error al guardar las calificaciones');
            throw new Error(errorMessage);
        }
        
        return jsonResponse;
    })
    .then((responseData) => {
        console.log('Guardado exitoso:', responseData);
        updateSaveIndicator(saveIndicator, '✓ Guardado', '#4CAF50');
        setTimeout(() => {
            updateSaveIndicator(saveIndicator, '', 'transparent');
        }, 2000);
    })
    .catch(error => {
        console.error('Error en la petición:', error);
        const errorMessage = error.message || 'Error desconocido al guardar';
        console.error('Mensaje de error:', errorMessage);
        updateSaveIndicator(saveIndicator, `✗ ${errorMessage}`, '#F44336');
    });
}

// Helper function to update save indicator
function updateSaveIndicator(element, text, color) {
    element.textContent = text;
    element.style.color = color;
    element.style.display = text ? 'inline-block' : 'none';
}

// Create save indicator if it doesn't exist
function createSaveIndicator() {
    const indicator = document.createElement('span');
    indicator.className = 'save-indicator';
    indicator.style.marginLeft = '10px';
    indicator.style.fontSize = '0.9em';
    document.querySelector('.card-title').appendChild(indicator);
    return indicator;
}

// Get CSS class based on grade
function getGradeClass(grade) {
    if (grade >= 8) return 'grade-excellent';
    if (grade >= 6) return 'grade-good';
    if (grade >= 4) return 'grade-regular';
    return 'grade-fail';
}

// Función para cargar las calificaciones existentes
async function cargarCalificaciones() {
    try {
        const idMateria = document.querySelector('input[name="id_materia"]')?.value;
        if (!idMateria) {
            console.warn('No se encontró el ID de la materia');
            return;
        }

        const baseUrl = window.location.origin + window.location.pathname.split('/').slice(0, -3).join('/');
        const url = new URL(`index/menu/ingresar/guardar_calificaciones.php?id_materia=${idMateria}`, baseUrl).toString();
        
        console.log('Cargando calificaciones desde:', url);
        
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        });
        
        const data = await response.json();
        
        if (data.success && data.data) {
            console.log('Calificaciones cargadas:', data.data);
            llenarCamposCalificaciones(data.data);
        } else {
            console.error('Error al cargar calificaciones:', data.message || 'Error desconocido');
        }
    } catch (error) {
        console.error('Error al cargar calificaciones:', error);
    }
}

// Función para llenar los campos con las calificaciones existentes
function llenarCamposCalificaciones(calificaciones) {
    Object.entries(calificaciones).forEach(([alumnoId, notas]) => {
        Object.entries(notas).forEach(([tipoNota, valor]) => {
            if (valor !== null) {
                const input = document.querySelector(`input[name="notas[${alumnoId}][${tipoNota}]"]`);
                if (input) {
                    input.value = valor;
                    // Si es parcial1 o parcial2, calcular el promedio
                    if (tipoNota === 'parcial1' || tipoNota === 'parcial2') {
                        calcularPromedio(input);
                    }
                }
            }
        });
    });
}

// Inicialización
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('form-calificaciones');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
        });
        
        // Cargar calificaciones existentes al iniciar
        cargarCalificaciones();
    }
});