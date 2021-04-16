from pdfrw import PdfReader

pdf = PdfReader('./Solicitud_Reclamacion.pdf')
print(pdf.keys())
print(pdf.Info)
print(pdf.Root.keys())
print('PDF has {} pages'.format(len(pdf.pages)))