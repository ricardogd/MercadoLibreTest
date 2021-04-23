//
//  ProductDescriptionViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class ProductDescriptionViewModelTests: BaseTestClass {
    
    //MARK: - Common values
    enum Constants {
        static let productDescriptionJSON = "ProductDetailDescription"
    }
    
    enum ExpectedValues {
        static let productDescription: String = """
CRECIENDO TIENDA OFICIAL TU BEBE MERECE SÓLO LO MEJOR - MEJOR CRECIENDO. MERCADO LÍDER PLATINUM - IMPORTADORES DE LAS MEJORES MARCAS. Cunas - Cochecitos – Butacas / Booster - Huevitos - Sillas de Comer - Juguetes para Bebes, niños y Accesorios. CONTAMOS CON SUCURSALES EN: FLORES - BELGRANO - MARTÍNEZ - PALERMO - BARRIO NORTE - VILLA RAFFO - MORÓN - TORTUGUITAS - PILAR - LOMAS DE ZAMORA CASA CENTRAL VILLA ADELINA: Venta online de lunes a viernes 8.00 a 17.00 hs y sábados de 8.00 a 13.00 hs. CARACTERÍSTICAS * Modelo '' LANIN'' de calidad PREMIUM diseño Europeo. * Convertible en moisés y asiento. * Ideal de 0 hasta 36 meses de edad. * Posee amortización en el cuadro y en las ruedas. * Respaldo de asiento reclinable. * Incluye cubre pies y mosquitero. * Manillar regulable en altura con lazo de seguridad. * Porta Biberón superior. * Porta objetos inferiores. * Ruedas grandes de goma maciza con freno. * Modelo totalmente plegable. * Sistema de seguridad arnés de 5 puntos. * Materiales de calidad. * Ultra liviano (8.7 kg). Coche 3 en 1, cochecito, asiento moisés y butaquita para el auto. Asiento reversible y transformable en moisés. 3 posiciones de reclinado en ambos sentidos. Butaquita para el auto Cinturón de seguridad de 5 puntos. Capota XXL con borde metálico reforzado y visera. Barral frontal extraíble. Tapizado confortable, suave y lavable. Amortiguación en ruedas y estructura. Rudas delanteras móviles. Ruedas traseras todo terreno, con freno centralizado. Posavasos. Canasto porta objetos Travel System 3 en 1: Este modelo incluye la butaquita para el auto y además, su asiento se transforma en moisés Asiento reversible: En asiento puede instalarse mirando hacia delante como hacia atrás, y en ambas modalidades, como asiento o como moisés El asiento se transforma en moisés, para darle a tu bebé la posibilidad de viajar súper cómodo El manillar del coche puede regularse en 3 posiciones La parte trasera del asiento cuenta con un visor de malla, para ver a tu bebé durante el paseo con el asiento orientado hacia delante. Capota XXL con borde reforzado y visera, para proteger a tu bebé de los rayos solares El coche cuenta con amortiguación en sus ruedas y en su estructura, para brindarle a tu bebé los paseos más suaves y divertidos! Las ruedas traseras pueden ser retiradas de manera sencilla, gracias a su botón, para que puedas guardar el coche ocupando el menor espacio posible Posavasos lateral para llevar el vaso o la mamadera de tu bebé Tamaño del coche: Medidas abierto: 106 x 68 x 85 cm. Plegado: Medidas cerrado sólo chasis: 55 x 68 x 105 cm. El coche resiste hasta 25 kg. El coche con el asiento pesa 12 kg. La butaquita soporta hasta 13 kg. La butaquita pesa 3 kg HUEVITO O PORTA BEBE BUTACA PARA EL AUTO * Grupo 0 (hasta 13 kilos o 9 meses) * Fácil de transportar gracias a su manija de múltiples posiciones * El sistema de seguridad: arnés de 5 puntos necesario para la protección del niño * Capota desmontable * Fácil de instalar y liviano * Excelente calidad * Confortable del bebé. FACTURACIÓN: Realizamos facturas para consumidor final tipo B, no se realizan facturas A. FORMAS DE ENVÍO: ENVÍOS GRATIS por Mercado Envíos a todo el país, es exclusivo para productos que así lo especifican. OTROS ENVÍOS GRATIS: Ofrecemos retiros por cualquiera de nuestras 12 sucursales (Retiro en domicilio del vendedor). Luego de realizar la compra coordinamos el día y horario de retiro ya que debemos enviar el producto con su factura. GARANTÍA: Todos los productos cuentan con una garantía de hasta 6 meses, la misma es válida desde el momento de recepción del producto. Cuenta con un proceso de 30 días para su devolución total, para hacer uso de la misma el producto debe mantenerse en embalaje original y sin ningún tipo de uso.
"""
        static let defaultDescription = "No se añadió ninguna descripción para éste producto."
        static let productId = "Test1"
    }
    
    //MARK: - Test Variables
    let productDetailServiceMock =  ProductDetailServiceMock()
    
    //MARK: - Tests Get Product Description
    func testGetProductDescription_withDescriptionDataAndSuccessResponse_productDescription() {
        let data = getData(fromJSONFile: Constants.productDescriptionJSON)
        productDetailServiceMock.data = data ?? Data()
        productDetailServiceMock.isSuccess = true
        
        let viewModel = ProductDescriptionViewModel(withId: ExpectedValues.productId, serviceProvider: productDetailServiceMock)
        
        let expectation = self.expectation(description: "testGetProductDescription")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.description, ExpectedValues.productDescription)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetProductDescription_withFailureResponse_defaultProductDescription() {
        productDetailServiceMock.isSuccess = false
        
        let viewModel = ProductDescriptionViewModel(withId: ExpectedValues.productId, serviceProvider: productDetailServiceMock)
        
        let expectation = self.expectation(description: "testGetProductDescription")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.description, ExpectedValues.defaultDescription)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}

