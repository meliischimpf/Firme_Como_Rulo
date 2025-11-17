// Function to update the UI after an attendance change
function updateAttendanceUI(checkbox, isPresent) {
    const label = checkbox.closest('label');
    const statusText = label.querySelector('.status-text');
    const row = checkbox.closest('tr');
    
    // Update the status text
    if (statusText) {
        statusText.textContent = isPresent ? 'Presente' : 'Ausente';
        statusText.style.color = isPresent ? '#4CAF50' : '#f44336';
    }
    
    // Update the row styling
    if (row) {
        row.classList.toggle('present', isPresent);
    }
    
    // Update the checkbox state
    checkbox.checked = isPresent;
}

// Function to handle attendance registration
async function registrarAsistencia(id_alumno, id_materia, checkbox) {
    const presente = checkbox.checked;
    const fecha_asistencia = document.getElementById('fecha_asistencia')?.value || new Date().toISOString().split('T')[0];
    
    // Get the status text element
    const statusText = checkbox.closest('label')?.querySelector('.status-text');
    const originalText = statusText?.textContent || '';
    
    try {
        // Show loading state
        if (statusText) {
            statusText.textContent = 'Guardando...';
            statusText.style.color = '#666';
        }
        checkbox.disabled = true;
        
        const response = await fetch('gestionar_asistencia.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `id_alumno=${id_alumno}&id_materia=${id_materia}&presente=${presente}&fecha_asistencia=${fecha_asistencia}`
        });
        
        if (!response.ok) {
            throw new Error(`Error HTTP: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data.estado === 'exito') {
            // Update the UI with the new state
            updateAttendanceUI(checkbox, data.asistio);
            
            // Show success message
            if (window.Sonner) {
                window.Sonner.success('Asistencia actualizada', {
                    description: data.mensaje || 'La asistencia se actualizó correctamente'
                });
            }
        } else {
            throw new Error(data.mensaje || 'Error al actualizar la asistencia');
        }
    } catch (error) {
        console.error('Error al registrar asistencia:', error);
        
        // Revert the checkbox state
        checkbox.checked = !presente;
        
        // Show error message
        if (window.Sonner) {
            window.Sonner.error('Error', {
                description: error.message || 'No se pudo actualizar la asistencia. Intente nuevamente.'
            });
        }
        
        // Restore original status text
        if (statusText) {
            statusText.textContent = originalText;
            statusText.style.color = presente ? '#4CAF50' : '#f44336';
        }
    } finally {
        // Re-enable the checkbox
        checkbox.disabled = false;
    }
}

// Load saved attendances when the page loads
document.addEventListener('DOMContentLoaded', function() {
    // Add change event to date input to reload the page with the new date
    const fechaInput = document.getElementById('fecha_asistencia');
    if (fechaInput) {
        fechaInput.addEventListener('change', function() {
            const form = this.closest('form');
            if (form) {
                form.submit();
            }
        });
    }
    
    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});