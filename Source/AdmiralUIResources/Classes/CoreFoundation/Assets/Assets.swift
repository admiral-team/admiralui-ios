// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Category {
    public enum Outline {
      public static let acceptOutline = ImageAsset(name: "Category/Outline/acceptOutline")
      public static let acuringFutureOutline = ImageAsset(name: "Category/Outline/acuringFutureOutline")
      public static let acuringModernOutline = ImageAsset(name: "Category/Outline/acuringModernOutline")
      public static let addCommentOutline = ImageAsset(name: "Category/Outline/addCommentOutline")
      public static let alertOutline = ImageAsset(name: "Category/Outline/alertOutline")
      public static let bankOutline = ImageAsset(name: "Category/Outline/bankOutline")
      public static let bonusOutline = ImageAsset(name: "Category/Outline/bonusOutline")
      public static let bonusRubleOutline = ImageAsset(name: "Category/Outline/bonusRubleOutline")
      public static let bookOutline = ImageAsset(name: "Category/Outline/bookOutline")
      public static let burnOutline = ImageAsset(name: "Category/Outline/burnOutline")
      public static let busOutline = ImageAsset(name: "Category/Outline/busOutline")
      public static let carOutline = ImageAsset(name: "Category/Outline/carOutline")
      public static let chairOutline = ImageAsset(name: "Category/Outline/chairOutline")
      public static let chartOutline = ImageAsset(name: "Category/Outline/chartOutline")
      public static let chatOutline = ImageAsset(name: "Category/Outline/chatOutline")
      public static let chessKingOutline = ImageAsset(name: "Category/Outline/chessKingOutline")
      public static let chipOutline = ImageAsset(name: "Category/Outline/chipOutline")
      public static let clipboardOutline = ImageAsset(name: "Category/Outline/clipboardOutline")
      public static let colorOutline = ImageAsset(name: "Category/Outline/colorOutline")
      public static let commentOutline = ImageAsset(name: "Category/Outline/commentOutline")
      public static let componentOutline = ImageAsset(name: "Category/Outline/componentOutline")
      public static let creditOutline = ImageAsset(name: "Category/Outline/creditOutline")
      public static let cubeOutline = ImageAsset(name: "Category/Outline/cubeOutline")
      public static let deliveryOutline = ImageAsset(name: "Category/Outline/deliveryOutline")
      public static let depositOutline = ImageAsset(name: "Category/Outline/depositOutline")
      public static let desktopOutline = ImageAsset(name: "Category/Outline/desktopOutline")
      public static let diamondOutline = ImageAsset(name: "Category/Outline/diamondOutline")
      public static let elderlyOutline = ImageAsset(name: "Category/Outline/elderlyOutline")
      public static let envelopeOutline = ImageAsset(name: "Category/Outline/envelopeOutline")
      public static let flagOutline = ImageAsset(name: "Category/Outline/flagOutline")
      public static let gameOutline = ImageAsset(name: "Category/Outline/gameOutline")
      public static let globeOutline = ImageAsset(name: "Category/Outline/globeOutline")
      public static let governmentOutline = ImageAsset(name: "Category/Outline/governmentOutline")
      public static let gridOutline = ImageAsset(name: "Category/Outline/gridOutline")
      public static let heartOutline = ImageAsset(name: "Category/Outline/heartOutline")
      public static let homeAutocreditOutline = ImageAsset(name: "Category/Outline/homeAutocreditOutline")
      public static let hookOutline = ImageAsset(name: "Category/Outline/hookOutline")
      public static let iconsOutline = ImageAsset(name: "Category/Outline/iconsOutline")
      public static let ideaOutline = ImageAsset(name: "Category/Outline/ideaOutline")
      public static let invalidOutline = ImageAsset(name: "Category/Outline/invalidOutline")
      public static let layersOutline = ImageAsset(name: "Category/Outline/layersOutline")
      public static let layoutOutline = ImageAsset(name: "Category/Outline/layoutOutline")
      public static let levelUpOutline = ImageAsset(name: "Category/Outline/levelUpOutline")
      public static let lightningOutline = ImageAsset(name: "Category/Outline/lightningOutline")
      public static let magnetOutline = ImageAsset(name: "Category/Outline/magnetOutline")
      public static let maintenanceOutline = ImageAsset(name: "Category/Outline/maintenanceOutline")
      public static let maleOutline = ImageAsset(name: "Category/Outline/maleOutline")
      public static let martiniOutline = ImageAsset(name: "Category/Outline/martiniOutline")
      public static let medalOutline = ImageAsset(name: "Category/Outline/medalOutline")
      public static let megaphoneOutline = ImageAsset(name: "Category/Outline/megaphoneOutline")
      public static let mobileOutline = ImageAsset(name: "Category/Outline/mobileOutline")
      public static let multibonusOutline = ImageAsset(name: "Category/Outline/multibonusOutline")
      public static let pensionOutline = ImageAsset(name: "Category/Outline/pensionOutline")
      public static let pickupOutline = ImageAsset(name: "Category/Outline/pickupOutline")
      public static let pinOutline = ImageAsset(name: "Category/Outline/pinOutline")
      public static let planeOutline = ImageAsset(name: "Category/Outline/planeOutline")
      public static let postAutomatOutline = ImageAsset(name: "Category/Outline/postAutomatOutline")
      public static let postOutline = ImageAsset(name: "Category/Outline/postOutline")
      public static let pregnantOutline = ImageAsset(name: "Category/Outline/pregnantOutline")
      public static let receiptOutline = ImageAsset(name: "Category/Outline/receiptOutline")
      public static let receiptUpdateOutline = ImageAsset(name: "Category/Outline/receiptUpdateOutline")
      public static let schemeOutline = ImageAsset(name: "Category/Outline/schemeOutline")
      public static let shopCartOutline = ImageAsset(name: "Category/Outline/shopCartOutline")
      public static let shoppingBagOutline = ImageAsset(name: "Category/Outline/shoppingBagOutline")
      public static let showTableOutline = ImageAsset(name: "Category/Outline/showTableOutline")
      public static let storeOutline = ImageAsset(name: "Category/Outline/storeOutline")
      public static let studyOutline = ImageAsset(name: "Category/Outline/studyOutline")
      public static let tabletOutline = ImageAsset(name: "Category/Outline/tabletOutline")
      public static let treesOutline = ImageAsset(name: "Category/Outline/treesOutline")
      public static let trophyOutline = ImageAsset(name: "Category/Outline/trophyOutline")
      public static let typographyOutline = ImageAsset(name: "Category/Outline/typographyOutline")
      public static let usbOutline = ImageAsset(name: "Category/Outline/uSBOutline")
      public static let utensilsOutline = ImageAsset(name: "Category/Outline/utensilsOutline")
      public static let vipOutline = ImageAsset(name: "Category/Outline/vIPOutline")
      public static let vacationOutline = ImageAsset(name: "Category/Outline/vacationOutline")
      public static let voteOutline = ImageAsset(name: "Category/Outline/voteOutline")
      public static let wikiOutline = ImageAsset(name: "Category/Outline/wikiOutline")
      public static let workOutline = ImageAsset(name: "Category/Outline/workOutline")
    }
    public enum Solid {
      public static let acceptSolid = ImageAsset(name: "Category/Solid/acceptSolid")
      public static let acuringFutureSolid = ImageAsset(name: "Category/Solid/acuringFutureSolid")
      public static let acuringModernSolid = ImageAsset(name: "Category/Solid/acuringModernSolid")
      public static let addCommentSolid = ImageAsset(name: "Category/Solid/addCommentSolid")
      public static let alertSolid = ImageAsset(name: "Category/Solid/alertSolid")
      public static let bankSolid = ImageAsset(name: "Category/Solid/bankSolid")
      public static let bonusRubleSolid = ImageAsset(name: "Category/Solid/bonusRubleSolid")
      public static let bonusSolid = ImageAsset(name: "Category/Solid/bonusSolid")
      public static let bookSolid = ImageAsset(name: "Category/Solid/bookSolid")
      public static let burnSolid = ImageAsset(name: "Category/Solid/burnSolid")
      public static let busSolid = ImageAsset(name: "Category/Solid/busSolid")
      public static let carSolid = ImageAsset(name: "Category/Solid/carSolid")
      public static let chairSolid = ImageAsset(name: "Category/Solid/chairSolid")
      public static let chartSolid = ImageAsset(name: "Category/Solid/chartSolid")
      public static let chatSolid = ImageAsset(name: "Category/Solid/chatSolid")
      public static let chessKingSolid = ImageAsset(name: "Category/Solid/chessKingSolid")
      public static let chipSolid = ImageAsset(name: "Category/Solid/chipSolid")
      public static let clipboardSolid = ImageAsset(name: "Category/Solid/clipboardSolid")
      public static let colorSolid = ImageAsset(name: "Category/Solid/colorSolid")
      public static let commentSolid = ImageAsset(name: "Category/Solid/commentSolid")
      public static let componentSolid = ImageAsset(name: "Category/Solid/componentSolid")
      public static let creditSolid = ImageAsset(name: "Category/Solid/creditSolid")
      public static let cubeSolid = ImageAsset(name: "Category/Solid/cubeSolid")
      public static let deliverySolid = ImageAsset(name: "Category/Solid/deliverySolid")
      public static let depositSolid = ImageAsset(name: "Category/Solid/depositSolid")
      public static let desktopSolid = ImageAsset(name: "Category/Solid/desktopSolid")
      public static let diamondSolid = ImageAsset(name: "Category/Solid/diamondSolid")
      public static let elderlySolid = ImageAsset(name: "Category/Solid/elderlySolid")
      public static let envelopeSolid = ImageAsset(name: "Category/Solid/envelopeSolid")
      public static let flagSolid = ImageAsset(name: "Category/Solid/flagSolid")
      public static let gameSolid = ImageAsset(name: "Category/Solid/gameSolid")
      public static let globeSolid = ImageAsset(name: "Category/Solid/globeSolid")
      public static let governmentSolid = ImageAsset(name: "Category/Solid/governmentSolid")
      public static let gridSolid = ImageAsset(name: "Category/Solid/gridSolid")
      public static let heartSolid = ImageAsset(name: "Category/Solid/heartSolid")
      public static let homeAutocreditSolid = ImageAsset(name: "Category/Solid/homeAutocreditSolid")
      public static let hookSolid = ImageAsset(name: "Category/Solid/hookSolid")
      public static let iconsSolid = ImageAsset(name: "Category/Solid/iconsSolid")
      public static let ideaSolid = ImageAsset(name: "Category/Solid/ideaSolid")
      public static let invalidSolid = ImageAsset(name: "Category/Solid/invalidSolid")
      public static let layersSolid = ImageAsset(name: "Category/Solid/layersSolid")
      public static let layoutSolid = ImageAsset(name: "Category/Solid/layoutSolid")
      public static let levelUpSolid = ImageAsset(name: "Category/Solid/levelUpSolid")
      public static let lightningSolid = ImageAsset(name: "Category/Solid/lightningSolid")
      public static let magnetSolid = ImageAsset(name: "Category/Solid/magnetSolid")
      public static let maintenanceSolid = ImageAsset(name: "Category/Solid/maintenanceSolid")
      public static let maleSolid = ImageAsset(name: "Category/Solid/maleSolid")
      public static let martiniSolid = ImageAsset(name: "Category/Solid/martiniSolid")
      public static let medalSolid = ImageAsset(name: "Category/Solid/medalSolid")
      public static let megaphoneSolid = ImageAsset(name: "Category/Solid/megaphoneSolid")
      public static let mobileSolid = ImageAsset(name: "Category/Solid/mobileSolid")
      public static let multibonusSolid = ImageAsset(name: "Category/Solid/multibonusSolid")
      public static let pensionSolid = ImageAsset(name: "Category/Solid/pensionSolid")
      public static let pickupSolid = ImageAsset(name: "Category/Solid/pickupSolid")
      public static let pinSolid = ImageAsset(name: "Category/Solid/pinSolid")
      public static let planeSolid = ImageAsset(name: "Category/Solid/planeSolid")
      public static let postAutomatSolid = ImageAsset(name: "Category/Solid/postAutomatSolid")
      public static let postSolid = ImageAsset(name: "Category/Solid/postSolid")
      public static let pregnantSolid = ImageAsset(name: "Category/Solid/pregnantSolid")
      public static let receiptSolid = ImageAsset(name: "Category/Solid/receiptSolid")
      public static let receiptUpdateSolid = ImageAsset(name: "Category/Solid/receiptUpdateSolid")
      public static let schemeSolid = ImageAsset(name: "Category/Solid/schemeSolid")
      public static let shopCartSolid = ImageAsset(name: "Category/Solid/shopCartSolid")
      public static let shoppingBagSolid = ImageAsset(name: "Category/Solid/shoppingBagSolid")
      public static let showTableSolid = ImageAsset(name: "Category/Solid/showTableSolid")
      public static let storeSolid = ImageAsset(name: "Category/Solid/storeSolid")
      public static let studySolid = ImageAsset(name: "Category/Solid/studySolid")
      public static let tabletSolid = ImageAsset(name: "Category/Solid/tabletSolid")
      public static let treesSolid = ImageAsset(name: "Category/Solid/treesSolid")
      public static let trophySolid = ImageAsset(name: "Category/Solid/trophySolid")
      public static let typographySolid = ImageAsset(name: "Category/Solid/typographySolid")
      public static let usbSolid = ImageAsset(name: "Category/Solid/uSBSolid")
      public static let utensilsSolid = ImageAsset(name: "Category/Solid/utensilsSolid")
      public static let vipSolid = ImageAsset(name: "Category/Solid/vIPSolid")
      public static let vacationSolid = ImageAsset(name: "Category/Solid/vacationSolid")
      public static let voteSolid = ImageAsset(name: "Category/Solid/voteSolid")
      public static let wikiSolid = ImageAsset(name: "Category/Solid/wikiSolid")
      public static let workSolid = ImageAsset(name: "Category/Solid/workSolid")
    }
  }
  public enum Communication {
    public enum Outline {
      public static let headsetOutline = ImageAsset(name: "Communication/Outline/headsetOutline")
      public static let phoneOutline = ImageAsset(name: "Communication/Outline/phoneOutline")
      public static let simCardOutline = ImageAsset(name: "Communication/Outline/sIMCardOutline")
      public static let signalOutline = ImageAsset(name: "Communication/Outline/signalOutline")
      public static let telegrammOutline = ImageAsset(name: "Communication/Outline/telegrammOutline")
    }
    public enum Solid {
      public static let headsetSolid = ImageAsset(name: "Communication/Solid/headsetSolid")
      public static let phoneSolid = ImageAsset(name: "Communication/Solid/phoneSolid")
      public static let simCardSolid = ImageAsset(name: "Communication/Solid/sIMCardSolid")
      public static let signalSolid = ImageAsset(name: "Communication/Solid/signalSolid")
      public static let telegrammSolid = ImageAsset(name: "Communication/Solid/telegrammSolid")
    }
  }
  public enum Documents {
    public enum Outline {
      public static let accountDetailOutline = ImageAsset(name: "Documents/Outline/accountDetailOutline")
      public static let addFromTemplateOutline = ImageAsset(name: "Documents/Outline/addFromTemplateOutline")
      public static let addTemplateOutline = ImageAsset(name: "Documents/Outline/addTemplateOutline")
      public static let archiveOutline = ImageAsset(name: "Documents/Outline/archiveOutline")
      public static let catalogOutline = ImageAsset(name: "Documents/Outline/catalogOutline")
      public static let componentTemplateOutline = ImageAsset(name: "Documents/Outline/componentTemplateOutline")
      public static let copyOutline = ImageAsset(name: "Documents/Outline/copyOutline")
      public static let deleteDocsOutline = ImageAsset(name: "Documents/Outline/deleteDocsOutline")
      public static let deleteDocumentOutline = ImageAsset(name: "Documents/Outline/deleteDocumentOutline")
      public static let descriptionOutline = ImageAsset(name: "Documents/Outline/descriptionOutline")
      public static let docAttentionOutline = ImageAsset(name: "Documents/Outline/docAttentionOutline")
      public static let docExportOutline = ImageAsset(name: "Documents/Outline/docExportOutline")
      public static let docFinishedOutline = ImageAsset(name: "Documents/Outline/docFinishedOutline")
      public static let docOkOutline = ImageAsset(name: "Documents/Outline/docOkOutline")
      public static let docOperationsOutline = ImageAsset(name: "Documents/Outline/docOperationsOutline")
      public static let docProcessingOutline = ImageAsset(name: "Documents/Outline/docProcessingOutline")
      public static let docRegenerateOutline = ImageAsset(name: "Documents/Outline/docRegenerateOutline")
      public static let docSettingsOutline = ImageAsset(name: "Documents/Outline/docSettingsOutline")
      public static let docSignOutline = ImageAsset(name: "Documents/Outline/docSignOutline")
      public static let docSignVerifyOutline = ImageAsset(name: "Documents/Outline/docSignVerifyOutline")
      public static let docViewOutline = ImageAsset(name: "Documents/Outline/docViewOutline")
      public static let docsOutline = ImageAsset(name: "Documents/Outline/docsOutline")
      public static let documentAddOutline = ImageAsset(name: "Documents/Outline/documentAddOutline")
      public static let fileCurrencyOutline = ImageAsset(name: "Documents/Outline/fileCurrencyOutline")
      public static let filePDFOutline = ImageAsset(name: "Documents/Outline/filePDFOutline")
      public static let filePPTOutline = ImageAsset(name: "Documents/Outline/filePPTOutline")
      public static let fileSNGOutline = ImageAsset(name: "Documents/Outline/fileSNGOutline")
      public static let fileWordOutline = ImageAsset(name: "Documents/Outline/fileWordOutline")
      public static let fileXLSOutline = ImageAsset(name: "Documents/Outline/fileXLSOutline")
      public static let fileXMLOutline = ImageAsset(name: "Documents/Outline/fileXMLOutline")
      public static let folderOutline = ImageAsset(name: "Documents/Outline/folderOutline")
      public static let jpgOutline = ImageAsset(name: "Documents/Outline/jpgOutline")
      public static let rotateLeftOutline = ImageAsset(name: "Documents/Outline/rotateLeftOutline")
      public static let rotateRightOutline = ImageAsset(name: "Documents/Outline/rotateRightOutline")
      public static let sendSignOutline = ImageAsset(name: "Documents/Outline/sendSignOutline")
      public static let signOutline = ImageAsset(name: "Documents/Outline/signOutline")
      public static let tasksOutline = ImageAsset(name: "Documents/Outline/tasksOutline")
      public static let unsignOutline = ImageAsset(name: "Documents/Outline/unsignOutline")
      public static let verifySignOutline = ImageAsset(name: "Documents/Outline/verifySignOutline")
      public static let webOutline = ImageAsset(name: "Documents/Outline/webOutline")
    }
    public enum Solid {
      public static let accountDetailSolid = ImageAsset(name: "Documents/Solid/accountDetailSolid")
      public static let addFromTemplateSolid = ImageAsset(name: "Documents/Solid/addFromTemplateSolid")
      public static let addTemplateSolid = ImageAsset(name: "Documents/Solid/addTemplateSolid")
      public static let archiveSolid = ImageAsset(name: "Documents/Solid/archiveSolid")
      public static let catalogSolid = ImageAsset(name: "Documents/Solid/catalogSolid")
      public static let componentTemplateSolid = ImageAsset(name: "Documents/Solid/componentTemplateSolid")
      public static let copySolid = ImageAsset(name: "Documents/Solid/copySolid")
      public static let deleteDocsSolid = ImageAsset(name: "Documents/Solid/deleteDocsSolid")
      public static let deleteDocumentSolid = ImageAsset(name: "Documents/Solid/deleteDocumentSolid")
      public static let descriptionSolid = ImageAsset(name: "Documents/Solid/descriptionSolid")
      public static let docAttentionSolid = ImageAsset(name: "Documents/Solid/docAttentionSolid")
      public static let docExportSolid = ImageAsset(name: "Documents/Solid/docExportSolid")
      public static let docFinishedSolid = ImageAsset(name: "Documents/Solid/docFinishedSolid")
      public static let docOkSolid = ImageAsset(name: "Documents/Solid/docOkSolid")
      public static let docOperationsSolid = ImageAsset(name: "Documents/Solid/docOperationsSolid")
      public static let docProcessingSolid = ImageAsset(name: "Documents/Solid/docProcessingSolid")
      public static let docRegenerateSolid = ImageAsset(name: "Documents/Solid/docRegenerateSolid")
      public static let docSettingsSolid = ImageAsset(name: "Documents/Solid/docSettingsSolid")
      public static let docSignSolid = ImageAsset(name: "Documents/Solid/docSignSolid")
      public static let docSignVerifySolid = ImageAsset(name: "Documents/Solid/docSignVerifySolid")
      public static let docViewSolid = ImageAsset(name: "Documents/Solid/docViewSolid")
      public static let docsSolid = ImageAsset(name: "Documents/Solid/docsSolid")
      public static let documentAddSolid = ImageAsset(name: "Documents/Solid/documentAddSolid")
      public static let fileCurrencySolid = ImageAsset(name: "Documents/Solid/fileCurrencySolid")
      public static let filePDFSolid = ImageAsset(name: "Documents/Solid/filePDFSolid")
      public static let filePPTSolid = ImageAsset(name: "Documents/Solid/filePPTSolid")
      public static let fileSNGSolid = ImageAsset(name: "Documents/Solid/fileSNGSolid")
      public static let fileWordSolid = ImageAsset(name: "Documents/Solid/fileWordSolid")
      public static let fileXLSSolid = ImageAsset(name: "Documents/Solid/fileXLSSolid")
      public static let fileXMLSolid = ImageAsset(name: "Documents/Solid/fileXMLSolid")
      public static let folderSolid = ImageAsset(name: "Documents/Solid/folderSolid")
      public static let jpgSolid = ImageAsset(name: "Documents/Solid/jpgSolid")
      public static let rotateLeftSolid = ImageAsset(name: "Documents/Solid/rotateLeftSolid")
      public static let rotateRightSolid = ImageAsset(name: "Documents/Solid/rotateRightSolid")
      public static let sendSignSolid = ImageAsset(name: "Documents/Solid/sendSignSolid")
      public static let signSolid = ImageAsset(name: "Documents/Solid/signSolid")
      public static let tasksSolid = ImageAsset(name: "Documents/Solid/tasksSolid")
      public static let unsignSolid = ImageAsset(name: "Documents/Solid/unsignSolid")
      public static let verifySignSolid = ImageAsset(name: "Documents/Solid/verifySignSolid")
      public static let webSolid = ImageAsset(name: "Documents/Solid/webSolid")
    }
  }
  public enum Finance {
    public enum Outline {
      public static let brokerOutline = ImageAsset(name: "Finance/Outline/brokerOutline")
      public static let cvvOutline = ImageAsset(name: "Finance/Outline/cVVOutline")
      public static let cardOutline = ImageAsset(name: "Finance/Outline/cardOutline")
      public static let cardTOutline = ImageAsset(name: "Finance/Outline/cardTOutline")
      public static let cardTPOutline = ImageAsset(name: "Finance/Outline/cardTPOutline")
      public static let cashOutline = ImageAsset(name: "Finance/Outline/cashOutline")
      public static let cashboxOutline = ImageAsset(name: "Finance/Outline/cashboxOutline")
      public static let creditCardOutline = ImageAsset(name: "Finance/Outline/creditCardOutline")
      public static let debitCardOutline = ImageAsset(name: "Finance/Outline/debitCardOutline")
      public static let digitalMoneyOutline = ImageAsset(name: "Finance/Outline/digitalMoneyOutline")
      public static let eurOutline = ImageAsset(name: "Finance/Outline/eUROutline")
      public static let financeOutline = ImageAsset(name: "Finance/Outline/financeOutline")
      public static let gbpOutline = ImageAsset(name: "Finance/Outline/gBPOutline")
      public static let getCashOutline = ImageAsset(name: "Finance/Outline/getCashOutline")
      public static let goldOutline = ImageAsset(name: "Finance/Outline/goldOutline")
      public static let iisOutline = ImageAsset(name: "Finance/Outline/iISOutline")
      public static let jpyOutline = ImageAsset(name: "Finance/Outline/jPYOutline")
      public static let moneyOutline = ImageAsset(name: "Finance/Outline/moneyOutline")
      public static let multicurencyOutline = ImageAsset(name: "Finance/Outline/multicurencyOutline")
      public static let palladiumOutline = ImageAsset(name: "Finance/Outline/palladiumOutline")
      public static let payCashOutline = ImageAsset(name: "Finance/Outline/payCashOutline")
      public static let payrollCardOutline = ImageAsset(name: "Finance/Outline/payrollCardOutline")
      public static let personOutline = ImageAsset(name: "Finance/Outline/personOutline")
      public static let platinumOutline = ImageAsset(name: "Finance/Outline/platinumOutline")
      public static let rubOutline = ImageAsset(name: "Finance/Outline/rUBOutline")
      public static let silverOutline = ImageAsset(name: "Finance/Outline/silverOutline")
      public static let treasuryOutline = ImageAsset(name: "Finance/Outline/treasuryOutline")
      public static let uahOutline = ImageAsset(name: "Finance/Outline/uAHOutline")
      public static let usdOutline = ImageAsset(name: "Finance/Outline/uSDOutline")
    }
    public enum Solid {
      public static let brokerSolid = ImageAsset(name: "Finance/Solid/brokerSolid")
      public static let cvvSolid = ImageAsset(name: "Finance/Solid/cVVSolid")
      public static let cardSolid = ImageAsset(name: "Finance/Solid/cardSolid")
      public static let cardTPSolid = ImageAsset(name: "Finance/Solid/cardTPSolid")
      public static let cardTSolid = ImageAsset(name: "Finance/Solid/cardTSolid")
      public static let cashSolid = ImageAsset(name: "Finance/Solid/cashSolid")
      public static let cashboxSolid = ImageAsset(name: "Finance/Solid/cashboxSolid")
      public static let creditCardSolid = ImageAsset(name: "Finance/Solid/creditCardSolid")
      public static let debitCardSolid = ImageAsset(name: "Finance/Solid/debitCardSolid")
      public static let digitalMoneySolid = ImageAsset(name: "Finance/Solid/digitalMoneySolid")
      public static let eurSolid = ImageAsset(name: "Finance/Solid/eURSolid")
      public static let financeSolid = ImageAsset(name: "Finance/Solid/financeSolid")
      public static let gbpSolid = ImageAsset(name: "Finance/Solid/gBPSolid")
      public static let getCashSolid = ImageAsset(name: "Finance/Solid/getCashSolid")
      public static let goldSolid = ImageAsset(name: "Finance/Solid/goldSolid")
      public static let iisSolid = ImageAsset(name: "Finance/Solid/iISSolid")
      public static let jpySolid = ImageAsset(name: "Finance/Solid/jPYSolid")
      public static let moneySolid = ImageAsset(name: "Finance/Solid/moneySolid")
      public static let multicurencySolid = ImageAsset(name: "Finance/Solid/multicurencySolid")
      public static let palladiumSolid = ImageAsset(name: "Finance/Solid/palladiumSolid")
      public static let payCashSolid = ImageAsset(name: "Finance/Solid/payCashSolid")
      public static let payrollCardSolid = ImageAsset(name: "Finance/Solid/payrollCardSolid")
      public static let personSolid = ImageAsset(name: "Finance/Solid/personSolid")
      public static let platinumSolid = ImageAsset(name: "Finance/Solid/platinumSolid")
      public static let rubSolid = ImageAsset(name: "Finance/Solid/rUBSolid")
      public static let silverSolid = ImageAsset(name: "Finance/Solid/silverSolid")
      public static let treasurySolid = ImageAsset(name: "Finance/Solid/treasurySolid")
      public static let uahSolid = ImageAsset(name: "Finance/Solid/uAHSolid")
      public static let usdSolid = ImageAsset(name: "Finance/Solid/uSDSolid")
    }
  }
  public enum Location {
    public enum Outline {
      public static let gpsOutline = ImageAsset(name: "Location/Outline/gPSOutline")
      public static let locationOutline = ImageAsset(name: "Location/Outline/locationOutline")
    }
    public enum Solid {
      public static let gpsSolid = ImageAsset(name: "Location/Solid/gPSSolid")
      public static let locationSolid = ImageAsset(name: "Location/Solid/locationSolid")
    }
  }
  public enum Redact {
    public enum Outline {
      public static let alignCenterOutline = ImageAsset(name: "Redact/Outline/alignCenterOutline")
      public static let alignLeftOutline = ImageAsset(name: "Redact/Outline/alignLeftOutline")
      public static let alignMiddleOutline = ImageAsset(name: "Redact/Outline/alignMiddleOutline")
      public static let alignRightOutline = ImageAsset(name: "Redact/Outline/alignRightOutline")
      public static let alignTopOutline = ImageAsset(name: "Redact/Outline/alignTopOutline")
      public static let bgColorOutline = ImageAsset(name: "Redact/Outline/bgColorOutline")
      public static let borderBoldBottomOutline = ImageAsset(name: "Redact/Outline/borderBoldBottomOutline")
      public static let borderBoldLeftOutline = ImageAsset(name: "Redact/Outline/borderBoldLeftOutline")
      public static let borderBoldOutterOutline = ImageAsset(name: "Redact/Outline/borderBoldOutterOutline")
      public static let borderBoldRightOutline = ImageAsset(name: "Redact/Outline/borderBoldRightOutline")
      public static let borderBoldTopOutline = ImageAsset(name: "Redact/Outline/borderBoldTopOutline")
      public static let borderBottomOutline = ImageAsset(name: "Redact/Outline/borderBottomOutline")
      public static let borderClearOutline = ImageAsset(name: "Redact/Outline/borderClearOutline")
      public static let borderHorizontalOutline = ImageAsset(name: "Redact/Outline/borderHorizontalOutline")
      public static let borderInnerOutline = ImageAsset(name: "Redact/Outline/borderInnerOutline")
      public static let borderLeftOutline = ImageAsset(name: "Redact/Outline/borderLeftOutline")
      public static let borderOuterOutline = ImageAsset(name: "Redact/Outline/borderOuterOutline")
      public static let borderRightOutline = ImageAsset(name: "Redact/Outline/borderRightOutline")
      public static let borderStyleOutline = ImageAsset(name: "Redact/Outline/borderStyleOutline")
      public static let borderTopOutline = ImageAsset(name: "Redact/Outline/borderTopOutline")
      public static let borderVerticalOutline = ImageAsset(name: "Redact/Outline/borderVerticalOutline")
      public static let cellsDisconnectOutline = ImageAsset(name: "Redact/Outline/cellsDisconnectOutline")
      public static let cellsMergeOutline = ImageAsset(name: "Redact/Outline/cellsMergeOutline")
      public static let changeFieldOutline = ImageAsset(name: "Redact/Outline/changeFieldOutline")
      public static let columnDeleteOutline = ImageAsset(name: "Redact/Outline/columnDeleteOutline")
      public static let columnInsertAfterOutline = ImageAsset(name: "Redact/Outline/columnInsertAfterOutline")
      public static let columnInsertBeforeOutline = ImageAsset(name: "Redact/Outline/columnInsertBeforeOutline")
      public static let columnsOutline = ImageAsset(name: "Redact/Outline/columnsOutline")
      public static let deleteStyleOutline = ImageAsset(name: "Redact/Outline/deleteStyleOutline")
      public static let deleteTableOutline = ImageAsset(name: "Redact/Outline/deleteTableOutline")
      public static let elementFixedOutline = ImageAsset(name: "Redact/Outline/elementFixedOutline")
      public static let elementGrowHorizontallyOutline = ImageAsset(name: "Redact/Outline/elementGrowHorizontallyOutline")
      public static let elementGrowVerticallyOutline = ImageAsset(name: "Redact/Outline/elementGrowVerticallyOutline")
      public static let eraserOutline = ImageAsset(name: "Redact/Outline/eraserOutline")
      public static let fontStyleOutline = ImageAsset(name: "Redact/Outline/fontStyleOutline")
      public static let formatAlignJustifyOutline = ImageAsset(name: "Redact/Outline/formatAlignJustifyOutline")
      public static let formatPaintOutline = ImageAsset(name: "Redact/Outline/formatPaintOutline")
      public static let hideLeftPanelOutline = ImageAsset(name: "Redact/Outline/hideLeftPanelOutline")
      public static let hideRightPanelOutline = ImageAsset(name: "Redact/Outline/hideRightPanelOutline")
      public static let indentDecreaseOutline = ImageAsset(name: "Redact/Outline/indentDecreaseOutline")
      public static let indentIncreaseOutline = ImageAsset(name: "Redact/Outline/indentIncreaseOutline")
      public static let leftDoubleOutline = ImageAsset(name: "Redact/Outline/leftDoubleOutline")
      public static let lineSpacingOutline = ImageAsset(name: "Redact/Outline/lineSpacingOutline")
      public static let lineThroughOutline = ImageAsset(name: "Redact/Outline/lineThroughOutline")
      public static let listBulletedOutline = ImageAsset(name: "Redact/Outline/listBulletedOutline")
      public static let listNumberedOutline = ImageAsset(name: "Redact/Outline/listNumberedOutline")
      public static let listStyleOutline = ImageAsset(name: "Redact/Outline/listStyleOutline")
      public static let resizeTableOutline = ImageAsset(name: "Redact/Outline/resizeTableOutline")
      public static let rightDoubleOutline = ImageAsset(name: "Redact/Outline/rightDoubleOutline")
      public static let rowDeleteOutline = ImageAsset(name: "Redact/Outline/rowDeleteOutline")
      public static let rowInsertAfterOutline = ImageAsset(name: "Redact/Outline/rowInsertAfterOutline")
      public static let rowInsertBelowOutline = ImageAsset(name: "Redact/Outline/rowInsertBelowOutline")
      public static let spellCheckOutline = ImageAsset(name: "Redact/Outline/spellCheckOutline")
      public static let tableOutline = ImageAsset(name: "Redact/Outline/tableOutline")
      public static let textBoldOutline = ImageAsset(name: "Redact/Outline/textBoldOutline")
      public static let textItalicOutline = ImageAsset(name: "Redact/Outline/textItalicOutline")
      public static let textUnderlineOutline = ImageAsset(name: "Redact/Outline/textUnderlineOutline")
      public static let txtColorOutline = ImageAsset(name: "Redact/Outline/txtColorOutline")
    }
    public enum Solid {
      public static let eraserSolid = ImageAsset(name: "Redact/Solid/eraserSolid")
      public static let formatPaintSolid = ImageAsset(name: "Redact/Solid/formatPaintSolid")
    }
  }
  public enum Security {
    public enum Outline {
      public static let faceIDOutline = ImageAsset(name: "Security/Outline/faceIDOutline")
      public static let fingerprintOutline = ImageAsset(name: "Security/Outline/fingerprintOutline")
      public static let keyOutline = ImageAsset(name: "Security/Outline/keyOutline")
      public static let lockOutline = ImageAsset(name: "Security/Outline/lockOutline")
      public static let passwordOutline = ImageAsset(name: "Security/Outline/passwordOutline")
      public static let safetyCertificateOutline = ImageAsset(name: "Security/Outline/safetyCertificateOutline")
      public static let safetyOutline = ImageAsset(name: "Security/Outline/safetyOutline")
      public static let unlockOutline = ImageAsset(name: "Security/Outline/unlockOutline")
    }
    public enum Solid {
      public static let faceIDSolid = ImageAsset(name: "Security/Solid/faceIDSolid")
      public static let fingerprintSolid = ImageAsset(name: "Security/Solid/fingerprintSolid")
      public static let keySolid = ImageAsset(name: "Security/Solid/keySolid")
      public static let lockSolid = ImageAsset(name: "Security/Solid/lockSolid")
      public static let passwordSolid = ImageAsset(name: "Security/Solid/passwordSolid")
      public static let safetySolid = ImageAsset(name: "Security/Solid/safetySolid")
      public static let unlockSolid = ImageAsset(name: "Security/Solid/unlockSolid")
    }
  }
  public enum Service {
    public enum Outline {
      public static let agreedOutline = ImageAsset(name: "Service/Outline/agreedOutline")
      public static let archiveOutline = ImageAsset(name: "Service/Outline/archiveOutline")
      public static let checkClearOutline = ImageAsset(name: "Service/Outline/checkClearOutline")
      public static let checkOutline = ImageAsset(name: "Service/Outline/checkOutline")
      public static let closeCircleOutline = ImageAsset(name: "Service/Outline/closeCircleOutline")
      public static let closeOutline = ImageAsset(name: "Service/Outline/closeOutline")
      public static let cutOutline = ImageAsset(name: "Service/Outline/cutOutline")
      public static let dragOutline = ImageAsset(name: "Service/Outline/dragOutline")
      public static let errorOutline = ImageAsset(name: "Service/Outline/errorOutline")
      public static let errorTriangleOutline = ImageAsset(name: "Service/Outline/errorTriangleOutline")
      public static let eyeCloseOutline = ImageAsset(name: "Service/Outline/eyeCloseOutline")
      public static let eyeOutline = ImageAsset(name: "Service/Outline/eyeOutline")
      public static let helpOutline = ImageAsset(name: "Service/Outline/helpOutline")
      public static let infoOutline = ImageAsset(name: "Service/Outline/infoOutline")
      public static let menuOutline = ImageAsset(name: "Service/Outline/menuOutline")
      public static let minusCircleOutline = ImageAsset(name: "Service/Outline/minusCircleOutline")
      public static let minusOutline = ImageAsset(name: "Service/Outline/minusOutline")
      public static let pauseOutline = ImageAsset(name: "Service/Outline/pauseOutline")
      public static let playOutline = ImageAsset(name: "Service/Outline/playOutline")
      public static let plusCircleOutline = ImageAsset(name: "Service/Outline/plusCircleOutline")
      public static let plusOutline = ImageAsset(name: "Service/Outline/plusOutline")
      public static let processOutline = ImageAsset(name: "Service/Outline/processOutline")
      public static let sizeChangerHorizontalOutline = ImageAsset(name: "Service/Outline/sizeChangerHorizontalOutline")
      public static let sizeChangerVerticalOutline = ImageAsset(name: "Service/Outline/sizeChangerVerticalOutline")
      public static let smallCloseOutline = ImageAsset(name: "Service/Outline/smallCloseOutline")
      public static let thumbsDownOutline = ImageAsset(name: "Service/Outline/thumbsDownOutline")
      public static let thumbsUpOutline = ImageAsset(name: "Service/Outline/thumbsUpOutline")
    }
    public enum Solid {
      public static let agreedSolid = ImageAsset(name: "Service/Solid/agreedSolid")
      public static let archiveSolid = ImageAsset(name: "Service/Solid/archiveSolid")
      public static let checkSolid = ImageAsset(name: "Service/Solid/checkSolid")
      public static let closeCircleSolid = ImageAsset(name: "Service/Solid/closeCircleSolid")
      public static let closeSolid = ImageAsset(name: "Service/Solid/closeSolid")
      public static let cutSolid = ImageAsset(name: "Service/Solid/cutSolid")
      public static let dragSolid = ImageAsset(name: "Service/Solid/dragSolid")
      public static let errorSolid = ImageAsset(name: "Service/Solid/errorSolid")
      public static let errorTriangleSolid = ImageAsset(name: "Service/Solid/errorTriangleSolid")
      public static let eyeSolid = ImageAsset(name: "Service/Solid/eyeSolid")
      public static let helpSolid = ImageAsset(name: "Service/Solid/helpSolid")
      public static let infoSolid = ImageAsset(name: "Service/Solid/infoSolid")
      public static let menuSolid = ImageAsset(name: "Service/Solid/menuSolid")
      public static let minusSolid = ImageAsset(name: "Service/Solid/minusSolid")
      public static let openShiftSolid = ImageAsset(name: "Service/Solid/openShiftSolid")
      public static let pauseSolid = ImageAsset(name: "Service/Solid/pauseSolid")
      public static let playSolid = ImageAsset(name: "Service/Solid/playSolid")
      public static let plusCircleSolid = ImageAsset(name: "Service/Solid/plusCircleSolid")
      public static let plusSolid = ImageAsset(name: "Service/Solid/plusSolid")
      public static let processSolid = ImageAsset(name: "Service/Solid/processSolid")
      public static let smallCloseSolid = ImageAsset(name: "Service/Solid/smallCloseSolid")
      public static let thumbsDownSolid = ImageAsset(name: "Service/Solid/thumbsDownSolid")
      public static let thumbsUpSolid = ImageAsset(name: "Service/Solid/thumbsUpSolid")
    }
  }
  public enum System {
    public enum Outline {
      public static let arrowCrossOutline = ImageAsset(name: "System/Outline/arrowCrossOutline")
      public static let arrowDownOutline = ImageAsset(name: "System/Outline/arrowDownOutline")
      public static let arrowLeftOutline = ImageAsset(name: "System/Outline/arrowLeftOutline")
      public static let arrowRightOutline = ImageAsset(name: "System/Outline/arrowRightOutline")
      public static let arrowUpOutline = ImageAsset(name: "System/Outline/arrowUpOutline")
      public static let arrowsHorizontalOutline = ImageAsset(name: "System/Outline/arrowsHorizontalOutline")
      public static let arrowsVerticalOutline = ImageAsset(name: "System/Outline/arrowsVerticalOutline")
      public static let atOutline = ImageAsset(name: "System/Outline/atOutline")
      public static let attachFileOutline = ImageAsset(name: "System/Outline/attachFileOutline")
      public static let backOutline = ImageAsset(name: "System/Outline/backOutline")
      public static let barCodeOutline = ImageAsset(name: "System/Outline/barCodeOutline")
      public static let calculateOutline = ImageAsset(name: "System/Outline/calculateOutline")
      public static let calendarOkOutline = ImageAsset(name: "System/Outline/calendarOkOutline")
      public static let calendarOutline = ImageAsset(name: "System/Outline/calendarOutline")
      public static let calendarUpdateOutline = ImageAsset(name: "System/Outline/calendarUpdateOutline")
      public static let cameraOutline = ImageAsset(name: "System/Outline/cameraOutline")
      public static let cameraRemoveOutline = ImageAsset(name: "System/Outline/cameraRemoveOutline")
      public static let chevronDownOutline = ImageAsset(name: "System/Outline/chevronDownOutline")
      public static let chevronLeftOutline = ImageAsset(name: "System/Outline/chevronLeftOutline")
      public static let chevronRightOutline = ImageAsset(name: "System/Outline/chevronRightOutline")
      public static let chevronUpOutline = ImageAsset(name: "System/Outline/chevronUpOutline")
      public static let closeFullscreenOutline = ImageAsset(name: "System/Outline/closeFullscreenOutline")
      public static let darkModeOutline = ImageAsset(name: "System/Outline/darkModeOutline")
      public static let deleteOutline = ImageAsset(name: "System/Outline/deleteOutline")
      public static let doubleArrowLeftOutline = ImageAsset(name: "System/Outline/doubleArrowLeftOutline")
      public static let doubleArrowRightOutline = ImageAsset(name: "System/Outline/doubleArrowRightOutline")
      public static let downloadOutline = ImageAsset(name: "System/Outline/downloadOutline")
      public static let editOutline = ImageAsset(name: "System/Outline/editOutline")
      public static let emailOutline = ImageAsset(name: "System/Outline/emailOutline")
      public static let emailReadOutline = ImageAsset(name: "System/Outline/emailReadOutline")
      public static let exitOutline = ImageAsset(name: "System/Outline/exitOutline")
      public static let exportOutline = ImageAsset(name: "System/Outline/exportOutline")
      public static let eyedropperOutline = ImageAsset(name: "System/Outline/eyedropperOutline")
      public static let filterOutline = ImageAsset(name: "System/Outline/filterOutline")
      public static let homeOutline = ImageAsset(name: "System/Outline/homeOutline")
      public static let importOutline = ImageAsset(name: "System/Outline/importOutline")
      public static let inboxOutline = ImageAsset(name: "System/Outline/inboxOutline")
      public static let keyboardOutline = ImageAsset(name: "System/Outline/keyboardOutline")
      public static let linkOutline = ImageAsset(name: "System/Outline/linkOutline")
      public static let loaderOutline = ImageAsset(name: "System/Outline/loaderOutline")
      public static let moreHorizontalOutline = ImageAsset(name: "System/Outline/moreHorizontalOutline")
      public static let moreOutline = ImageAsset(name: "System/Outline/moreOutline")
      public static let moreVerticalOutline = ImageAsset(name: "System/Outline/moreVerticalOutline")
      public static let notificationsOffOutline = ImageAsset(name: "System/Outline/notificationsOffOutline")
      public static let notificationsOutline = ImageAsset(name: "System/Outline/notificationsOutline")
      public static let okSendOutline = ImageAsset(name: "System/Outline/okSendOutline")
      public static let openInFullOutline = ImageAsset(name: "System/Outline/openInFullOutline")
      public static let peopleOutline = ImageAsset(name: "System/Outline/peopleOutline")
      public static let personAddOutline = ImageAsset(name: "System/Outline/personAddOutline")
      public static let personLimitsOutline = ImageAsset(name: "System/Outline/personLimitsOutline")
      public static let personOutline = ImageAsset(name: "System/Outline/personOutline")
      public static let personPropertiesOutline = ImageAsset(name: "System/Outline/personPropertiesOutline")
      public static let personRefreshOutline = ImageAsset(name: "System/Outline/personRefreshOutline")
      public static let powerOutline = ImageAsset(name: "System/Outline/powerOutline")
      public static let printOutline = ImageAsset(name: "System/Outline/printOutline")
      public static let qrCodeOutline = ImageAsset(name: "System/Outline/qRCodeOutline")
      public static let redoOutline = ImageAsset(name: "System/Outline/redoOutline")
      public static let refuseOutline = ImageAsset(name: "System/Outline/refuseOutline")
      public static let refuseViewOutline = ImageAsset(name: "System/Outline/refuseViewOutline")
      public static let reportOutline = ImageAsset(name: "System/Outline/reportOutline")
      public static let saveOutline = ImageAsset(name: "System/Outline/saveOutline")
      public static let searchOutline = ImageAsset(name: "System/Outline/searchOutline")
      public static let settingsOutline = ImageAsset(name: "System/Outline/settingsOutline")
      public static let signInOutline = ImageAsset(name: "System/Outline/signInOutline")
      public static let smallArrowDownOutline = ImageAsset(name: "System/Outline/smallArrowDownOutline")
      public static let smallArrowLeftOutline = ImageAsset(name: "System/Outline/smallArrowLeftOutline")
      public static let smallArrowRightOutline = ImageAsset(name: "System/Outline/smallArrowRightOutline")
      public static let smallArrowUpOutline = ImageAsset(name: "System/Outline/smallArrowUpOutline")
      public static let sortDownOutline = ImageAsset(name: "System/Outline/sortDownOutline")
      public static let sortOutline = ImageAsset(name: "System/Outline/sortOutline")
      public static let sortUpOutline = ImageAsset(name: "System/Outline/sortUpOutline")
      public static let starOutline = ImageAsset(name: "System/Outline/starOutline")
      public static let syncForbidOutline = ImageAsset(name: "System/Outline/syncForbidOutline")
      public static let syncPermitOutline = ImageAsset(name: "System/Outline/syncPermitOutline")
      public static let thirdPersonOutline = ImageAsset(name: "System/Outline/thirdPersonOutline")
      public static let timeOutline = ImageAsset(name: "System/Outline/timeOutline")
      public static let toCustomerOutline = ImageAsset(name: "System/Outline/toCustomerOutline")
      public static let tuneOutline = ImageAsset(name: "System/Outline/tuneOutline")
      public static let undoOutline = ImageAsset(name: "System/Outline/undoOutline")
      public static let unlinkOutline = ImageAsset(name: "System/Outline/unlinkOutline")
      public static let updateOutline = ImageAsset(name: "System/Outline/updateOutline")
      public static let uploadOutline = ImageAsset(name: "System/Outline/uploadOutline")
      public static let userDeleteOutline = ImageAsset(name: "System/Outline/userDeleteOutline")
      public static let userRoleOutline = ImageAsset(name: "System/Outline/userRoleOutline")
      public static let viewHistoryOutline = ImageAsset(name: "System/Outline/viewHistoryOutline")
      public static let zoomInOutline = ImageAsset(name: "System/Outline/zoomInOutline")
      public static let zoomOutOutline = ImageAsset(name: "System/Outline/zoomOutOutline")
    }
    public enum Solid {
      public static let arrowCrossSolid = ImageAsset(name: "System/Solid/arrowCrossSolid")
      public static let arrowDownSolid = ImageAsset(name: "System/Solid/arrowDownSolid")
      public static let arrowLeftSolid = ImageAsset(name: "System/Solid/arrowLeftSolid")
      public static let arrowRightSolid = ImageAsset(name: "System/Solid/arrowRightSolid")
      public static let arrowUpSolid = ImageAsset(name: "System/Solid/arrowUpSolid")
      public static let arrowsHorizontalSolid = ImageAsset(name: "System/Solid/arrowsHorizontalSolid")
      public static let arrowsVerticalSolid = ImageAsset(name: "System/Solid/arrowsVerticalSolid")
      public static let atSolid = ImageAsset(name: "System/Solid/atSolid")
      public static let attachFileSolid = ImageAsset(name: "System/Solid/attachFileSolid")
      public static let backSolid = ImageAsset(name: "System/Solid/backSolid")
      public static let barCodeSolid = ImageAsset(name: "System/Solid/barCodeSolid")
      public static let calculateSolid = ImageAsset(name: "System/Solid/calculateSolid")
      public static let calendarOkSolid = ImageAsset(name: "System/Solid/calendarOkSolid")
      public static let calendarSolid = ImageAsset(name: "System/Solid/calendarSolid")
      public static let calendarUpdateSolid = ImageAsset(name: "System/Solid/calendarUpdateSolid")
      public static let cameraRemoveSolid = ImageAsset(name: "System/Solid/cameraRemoveSolid")
      public static let cameraSolid = ImageAsset(name: "System/Solid/cameraSolid")
      public static let chevronDownSolid = ImageAsset(name: "System/Solid/chevronDownSolid")
      public static let chevronLeftSolid = ImageAsset(name: "System/Solid/chevronLeftSolid")
      public static let chevronRightSolid = ImageAsset(name: "System/Solid/chevronRightSolid")
      public static let chevronUpSolid = ImageAsset(name: "System/Solid/chevronUpSolid")
      public static let closeFullscreenSolid = ImageAsset(name: "System/Solid/closeFullscreenSolid")
      public static let darkModeSolid = ImageAsset(name: "System/Solid/darkModeSolid")
      public static let deleteSolid = ImageAsset(name: "System/Solid/deleteSolid")
      public static let doubleArrowLeftSolid = ImageAsset(name: "System/Solid/doubleArrowLeftSolid")
      public static let doubleArrowRightSolid = ImageAsset(name: "System/Solid/doubleArrowRightSolid")
      public static let downloadSolid = ImageAsset(name: "System/Solid/downloadSolid")
      public static let editSolid = ImageAsset(name: "System/Solid/editSolid")
      public static let emailReadSolid = ImageAsset(name: "System/Solid/emailReadSolid")
      public static let emailSolid = ImageAsset(name: "System/Solid/emailSolid")
      public static let exitSolid = ImageAsset(name: "System/Solid/exitSolid")
      public static let exportSolid = ImageAsset(name: "System/Solid/exportSolid")
      public static let eyedropperSolid = ImageAsset(name: "System/Solid/eyedropperSolid")
      public static let filterSolid = ImageAsset(name: "System/Solid/filterSolid")
      public static let homeSolid = ImageAsset(name: "System/Solid/homeSolid")
      public static let importSolid = ImageAsset(name: "System/Solid/importSolid")
      public static let inboxSolid = ImageAsset(name: "System/Solid/inboxSolid")
      public static let keyboardSolid = ImageAsset(name: "System/Solid/keyboardSolid")
      public static let linkSolid = ImageAsset(name: "System/Solid/linkSolid")
      public static let loaderSolid = ImageAsset(name: "System/Solid/loaderSolid")
      public static let moreHorizontalSolid = ImageAsset(name: "System/Solid/moreHorizontalSolid")
      public static let moreSolid = ImageAsset(name: "System/Solid/moreSolid")
      public static let moreVerticalSolid = ImageAsset(name: "System/Solid/moreVerticalSolid")
      public static let notificationsOffSolid = ImageAsset(name: "System/Solid/notificationsOffSolid")
      public static let notificationsSolid = ImageAsset(name: "System/Solid/notificationsSolid")
      public static let okSendSolid = ImageAsset(name: "System/Solid/okSendSolid")
      public static let openInFullSolid = ImageAsset(name: "System/Solid/openInFullSolid")
      public static let peopleSolid = ImageAsset(name: "System/Solid/peopleSolid")
      public static let personAddSolid = ImageAsset(name: "System/Solid/personAddSolid")
      public static let personLimitSolid = ImageAsset(name: "System/Solid/personLimitSolid")
      public static let personPropertiesSolid = ImageAsset(name: "System/Solid/personPropertiesSolid")
      public static let personRefreshSolid = ImageAsset(name: "System/Solid/personRefreshSolid")
      public static let personSolid = ImageAsset(name: "System/Solid/personSolid")
      public static let powerSolid = ImageAsset(name: "System/Solid/powerSolid")
      public static let printSolid = ImageAsset(name: "System/Solid/printSolid")
      public static let qrCodeSolid = ImageAsset(name: "System/Solid/qRCodeSolid")
      public static let redoSolid = ImageAsset(name: "System/Solid/redoSolid")
      public static let refuseSolid = ImageAsset(name: "System/Solid/refuseSolid")
      public static let reportSolid = ImageAsset(name: "System/Solid/reportSolid")
      public static let saveSolid = ImageAsset(name: "System/Solid/saveSolid")
      public static let searchSolid = ImageAsset(name: "System/Solid/searchSolid")
      public static let settingsSolid = ImageAsset(name: "System/Solid/settingsSolid")
      public static let signInSolid = ImageAsset(name: "System/Solid/signInSolid")
      public static let smallArrowDownSolid = ImageAsset(name: "System/Solid/smallArrowDownSolid")
      public static let smallArrowLeftSolid = ImageAsset(name: "System/Solid/smallArrowLeftSolid")
      public static let smallArrowRightSolid = ImageAsset(name: "System/Solid/smallArrowRightSolid")
      public static let smallArrowUpSolid = ImageAsset(name: "System/Solid/smallArrowUpSolid")
      public static let sortDownSolid = ImageAsset(name: "System/Solid/sortDownSolid")
      public static let sortSolid = ImageAsset(name: "System/Solid/sortSolid")
      public static let sortUpSolid = ImageAsset(name: "System/Solid/sortUpSolid")
      public static let starSolid = ImageAsset(name: "System/Solid/starSolid")
      public static let thirdPersonSolid = ImageAsset(name: "System/Solid/thirdPersonSolid")
      public static let timeSolid = ImageAsset(name: "System/Solid/timeSolid")
      public static let toCustomerSolid = ImageAsset(name: "System/Solid/toCustomerSolid")
      public static let tuneSolid = ImageAsset(name: "System/Solid/tuneSolid")
      public static let undoSolid = ImageAsset(name: "System/Solid/undoSolid")
      public static let updateSolid = ImageAsset(name: "System/Solid/updateSolid")
      public static let uploadSolid = ImageAsset(name: "System/Solid/uploadSolid")
      public static let userDeleteSolid = ImageAsset(name: "System/Solid/userDeleteSolid")
      public static let userRoleSolid = ImageAsset(name: "System/Solid/userRoleSolid")
      public static let zoomInSolid = ImageAsset(name: "System/Solid/zoomInSolid")
      public static let zoomOutSolid = ImageAsset(name: "System/Solid/zoomOutSolid")
    }
  }

  // swiftlint:disable trailing_comma
  public static let allImages: [ImageAsset] = [
    Category.Outline.acceptOutline,
    Category.Outline.acuringFutureOutline,
    Category.Outline.acuringModernOutline,
    Category.Outline.addCommentOutline,
    Category.Outline.alertOutline,
    Category.Outline.bankOutline,
    Category.Outline.bonusOutline,
    Category.Outline.bonusRubleOutline,
    Category.Outline.bookOutline,
    Category.Outline.burnOutline,
    Category.Outline.busOutline,
    Category.Outline.carOutline,
    Category.Outline.chairOutline,
    Category.Outline.chartOutline,
    Category.Outline.chatOutline,
    Category.Outline.chessKingOutline,
    Category.Outline.chipOutline,
    Category.Outline.clipboardOutline,
    Category.Outline.colorOutline,
    Category.Outline.commentOutline,
    Category.Outline.componentOutline,
    Category.Outline.creditOutline,
    Category.Outline.cubeOutline,
    Category.Outline.deliveryOutline,
    Category.Outline.depositOutline,
    Category.Outline.desktopOutline,
    Category.Outline.diamondOutline,
    Category.Outline.elderlyOutline,
    Category.Outline.envelopeOutline,
    Category.Outline.flagOutline,
    Category.Outline.gameOutline,
    Category.Outline.globeOutline,
    Category.Outline.governmentOutline,
    Category.Outline.gridOutline,
    Category.Outline.heartOutline,
    Category.Outline.homeAutocreditOutline,
    Category.Outline.hookOutline,
    Category.Outline.iconsOutline,
    Category.Outline.ideaOutline,
    Category.Outline.invalidOutline,
    Category.Outline.layersOutline,
    Category.Outline.layoutOutline,
    Category.Outline.levelUpOutline,
    Category.Outline.lightningOutline,
    Category.Outline.magnetOutline,
    Category.Outline.maintenanceOutline,
    Category.Outline.maleOutline,
    Category.Outline.martiniOutline,
    Category.Outline.medalOutline,
    Category.Outline.megaphoneOutline,
    Category.Outline.mobileOutline,
    Category.Outline.multibonusOutline,
    Category.Outline.pensionOutline,
    Category.Outline.pickupOutline,
    Category.Outline.pinOutline,
    Category.Outline.planeOutline,
    Category.Outline.postAutomatOutline,
    Category.Outline.postOutline,
    Category.Outline.pregnantOutline,
    Category.Outline.receiptOutline,
    Category.Outline.receiptUpdateOutline,
    Category.Outline.schemeOutline,
    Category.Outline.shopCartOutline,
    Category.Outline.shoppingBagOutline,
    Category.Outline.showTableOutline,
    Category.Outline.storeOutline,
    Category.Outline.studyOutline,
    Category.Outline.tabletOutline,
    Category.Outline.treesOutline,
    Category.Outline.trophyOutline,
    Category.Outline.typographyOutline,
    Category.Outline.usbOutline,
    Category.Outline.utensilsOutline,
    Category.Outline.vipOutline,
    Category.Outline.vacationOutline,
    Category.Outline.voteOutline,
    Category.Outline.wikiOutline,
    Category.Outline.workOutline,
    Category.Solid.acceptSolid,
    Category.Solid.acuringFutureSolid,
    Category.Solid.acuringModernSolid,
    Category.Solid.addCommentSolid,
    Category.Solid.alertSolid,
    Category.Solid.bankSolid,
    Category.Solid.bonusRubleSolid,
    Category.Solid.bonusSolid,
    Category.Solid.bookSolid,
    Category.Solid.burnSolid,
    Category.Solid.busSolid,
    Category.Solid.carSolid,
    Category.Solid.chairSolid,
    Category.Solid.chartSolid,
    Category.Solid.chatSolid,
    Category.Solid.chessKingSolid,
    Category.Solid.chipSolid,
    Category.Solid.clipboardSolid,
    Category.Solid.colorSolid,
    Category.Solid.commentSolid,
    Category.Solid.componentSolid,
    Category.Solid.creditSolid,
    Category.Solid.cubeSolid,
    Category.Solid.deliverySolid,
    Category.Solid.depositSolid,
    Category.Solid.desktopSolid,
    Category.Solid.diamondSolid,
    Category.Solid.elderlySolid,
    Category.Solid.envelopeSolid,
    Category.Solid.flagSolid,
    Category.Solid.gameSolid,
    Category.Solid.globeSolid,
    Category.Solid.governmentSolid,
    Category.Solid.gridSolid,
    Category.Solid.heartSolid,
    Category.Solid.homeAutocreditSolid,
    Category.Solid.hookSolid,
    Category.Solid.iconsSolid,
    Category.Solid.ideaSolid,
    Category.Solid.invalidSolid,
    Category.Solid.layersSolid,
    Category.Solid.layoutSolid,
    Category.Solid.levelUpSolid,
    Category.Solid.lightningSolid,
    Category.Solid.magnetSolid,
    Category.Solid.maintenanceSolid,
    Category.Solid.maleSolid,
    Category.Solid.martiniSolid,
    Category.Solid.medalSolid,
    Category.Solid.megaphoneSolid,
    Category.Solid.mobileSolid,
    Category.Solid.multibonusSolid,
    Category.Solid.pensionSolid,
    Category.Solid.pickupSolid,
    Category.Solid.pinSolid,
    Category.Solid.planeSolid,
    Category.Solid.postAutomatSolid,
    Category.Solid.postSolid,
    Category.Solid.pregnantSolid,
    Category.Solid.receiptSolid,
    Category.Solid.receiptUpdateSolid,
    Category.Solid.schemeSolid,
    Category.Solid.shopCartSolid,
    Category.Solid.shoppingBagSolid,
    Category.Solid.showTableSolid,
    Category.Solid.storeSolid,
    Category.Solid.studySolid,
    Category.Solid.tabletSolid,
    Category.Solid.treesSolid,
    Category.Solid.trophySolid,
    Category.Solid.typographySolid,
    Category.Solid.usbSolid,
    Category.Solid.utensilsSolid,
    Category.Solid.vipSolid,
    Category.Solid.vacationSolid,
    Category.Solid.voteSolid,
    Category.Solid.wikiSolid,
    Category.Solid.workSolid,
    Communication.Outline.headsetOutline,
    Communication.Outline.phoneOutline,
    Communication.Outline.simCardOutline,
    Communication.Outline.signalOutline,
    Communication.Outline.telegrammOutline,
    Communication.Solid.headsetSolid,
    Communication.Solid.phoneSolid,
    Communication.Solid.simCardSolid,
    Communication.Solid.signalSolid,
    Communication.Solid.telegrammSolid,
    Documents.Outline.accountDetailOutline,
    Documents.Outline.addFromTemplateOutline,
    Documents.Outline.addTemplateOutline,
    Documents.Outline.archiveOutline,
    Documents.Outline.catalogOutline,
    Documents.Outline.componentTemplateOutline,
    Documents.Outline.copyOutline,
    Documents.Outline.deleteDocsOutline,
    Documents.Outline.deleteDocumentOutline,
    Documents.Outline.descriptionOutline,
    Documents.Outline.docAttentionOutline,
    Documents.Outline.docExportOutline,
    Documents.Outline.docFinishedOutline,
    Documents.Outline.docOkOutline,
    Documents.Outline.docOperationsOutline,
    Documents.Outline.docProcessingOutline,
    Documents.Outline.docRegenerateOutline,
    Documents.Outline.docSettingsOutline,
    Documents.Outline.docSignOutline,
    Documents.Outline.docSignVerifyOutline,
    Documents.Outline.docViewOutline,
    Documents.Outline.docsOutline,
    Documents.Outline.documentAddOutline,
    Documents.Outline.fileCurrencyOutline,
    Documents.Outline.filePDFOutline,
    Documents.Outline.filePPTOutline,
    Documents.Outline.fileSNGOutline,
    Documents.Outline.fileWordOutline,
    Documents.Outline.fileXLSOutline,
    Documents.Outline.fileXMLOutline,
    Documents.Outline.folderOutline,
    Documents.Outline.jpgOutline,
    Documents.Outline.rotateLeftOutline,
    Documents.Outline.rotateRightOutline,
    Documents.Outline.sendSignOutline,
    Documents.Outline.signOutline,
    Documents.Outline.tasksOutline,
    Documents.Outline.unsignOutline,
    Documents.Outline.verifySignOutline,
    Documents.Outline.webOutline,
    Documents.Solid.accountDetailSolid,
    Documents.Solid.addFromTemplateSolid,
    Documents.Solid.addTemplateSolid,
    Documents.Solid.archiveSolid,
    Documents.Solid.catalogSolid,
    Documents.Solid.componentTemplateSolid,
    Documents.Solid.copySolid,
    Documents.Solid.deleteDocsSolid,
    Documents.Solid.deleteDocumentSolid,
    Documents.Solid.descriptionSolid,
    Documents.Solid.docAttentionSolid,
    Documents.Solid.docExportSolid,
    Documents.Solid.docFinishedSolid,
    Documents.Solid.docOkSolid,
    Documents.Solid.docOperationsSolid,
    Documents.Solid.docProcessingSolid,
    Documents.Solid.docRegenerateSolid,
    Documents.Solid.docSettingsSolid,
    Documents.Solid.docSignSolid,
    Documents.Solid.docSignVerifySolid,
    Documents.Solid.docViewSolid,
    Documents.Solid.docsSolid,
    Documents.Solid.documentAddSolid,
    Documents.Solid.fileCurrencySolid,
    Documents.Solid.filePDFSolid,
    Documents.Solid.filePPTSolid,
    Documents.Solid.fileSNGSolid,
    Documents.Solid.fileWordSolid,
    Documents.Solid.fileXLSSolid,
    Documents.Solid.fileXMLSolid,
    Documents.Solid.folderSolid,
    Documents.Solid.jpgSolid,
    Documents.Solid.rotateLeftSolid,
    Documents.Solid.rotateRightSolid,
    Documents.Solid.sendSignSolid,
    Documents.Solid.signSolid,
    Documents.Solid.tasksSolid,
    Documents.Solid.unsignSolid,
    Documents.Solid.verifySignSolid,
    Documents.Solid.webSolid,
    Finance.Outline.brokerOutline,
    Finance.Outline.cvvOutline,
    Finance.Outline.cardOutline,
    Finance.Outline.cardTOutline,
    Finance.Outline.cardTPOutline,
    Finance.Outline.cashOutline,
    Finance.Outline.cashboxOutline,
    Finance.Outline.creditCardOutline,
    Finance.Outline.debitCardOutline,
    Finance.Outline.digitalMoneyOutline,
    Finance.Outline.eurOutline,
    Finance.Outline.financeOutline,
    Finance.Outline.gbpOutline,
    Finance.Outline.getCashOutline,
    Finance.Outline.goldOutline,
    Finance.Outline.iisOutline,
    Finance.Outline.jpyOutline,
    Finance.Outline.moneyOutline,
    Finance.Outline.multicurencyOutline,
    Finance.Outline.palladiumOutline,
    Finance.Outline.payCashOutline,
    Finance.Outline.payrollCardOutline,
    Finance.Outline.personOutline,
    Finance.Outline.platinumOutline,
    Finance.Outline.rubOutline,
    Finance.Outline.silverOutline,
    Finance.Outline.treasuryOutline,
    Finance.Outline.uahOutline,
    Finance.Outline.usdOutline,
    Finance.Solid.brokerSolid,
    Finance.Solid.cvvSolid,
    Finance.Solid.cardSolid,
    Finance.Solid.cardTPSolid,
    Finance.Solid.cardTSolid,
    Finance.Solid.cashSolid,
    Finance.Solid.cashboxSolid,
    Finance.Solid.creditCardSolid,
    Finance.Solid.debitCardSolid,
    Finance.Solid.digitalMoneySolid,
    Finance.Solid.eurSolid,
    Finance.Solid.financeSolid,
    Finance.Solid.gbpSolid,
    Finance.Solid.getCashSolid,
    Finance.Solid.goldSolid,
    Finance.Solid.iisSolid,
    Finance.Solid.jpySolid,
    Finance.Solid.moneySolid,
    Finance.Solid.multicurencySolid,
    Finance.Solid.palladiumSolid,
    Finance.Solid.payCashSolid,
    Finance.Solid.payrollCardSolid,
    Finance.Solid.personSolid,
    Finance.Solid.platinumSolid,
    Finance.Solid.rubSolid,
    Finance.Solid.silverSolid,
    Finance.Solid.treasurySolid,
    Finance.Solid.uahSolid,
    Finance.Solid.usdSolid,
    Location.Outline.gpsOutline,
    Location.Outline.locationOutline,
    Location.Solid.gpsSolid,
    Location.Solid.locationSolid,
    Redact.Outline.alignCenterOutline,
    Redact.Outline.alignLeftOutline,
    Redact.Outline.alignMiddleOutline,
    Redact.Outline.alignRightOutline,
    Redact.Outline.alignTopOutline,
    Redact.Outline.bgColorOutline,
    Redact.Outline.borderBoldBottomOutline,
    Redact.Outline.borderBoldLeftOutline,
    Redact.Outline.borderBoldOutterOutline,
    Redact.Outline.borderBoldRightOutline,
    Redact.Outline.borderBoldTopOutline,
    Redact.Outline.borderBottomOutline,
    Redact.Outline.borderClearOutline,
    Redact.Outline.borderHorizontalOutline,
    Redact.Outline.borderInnerOutline,
    Redact.Outline.borderLeftOutline,
    Redact.Outline.borderOuterOutline,
    Redact.Outline.borderRightOutline,
    Redact.Outline.borderStyleOutline,
    Redact.Outline.borderTopOutline,
    Redact.Outline.borderVerticalOutline,
    Redact.Outline.cellsDisconnectOutline,
    Redact.Outline.cellsMergeOutline,
    Redact.Outline.changeFieldOutline,
    Redact.Outline.columnDeleteOutline,
    Redact.Outline.columnInsertAfterOutline,
    Redact.Outline.columnInsertBeforeOutline,
    Redact.Outline.columnsOutline,
    Redact.Outline.deleteStyleOutline,
    Redact.Outline.deleteTableOutline,
    Redact.Outline.elementFixedOutline,
    Redact.Outline.elementGrowHorizontallyOutline,
    Redact.Outline.elementGrowVerticallyOutline,
    Redact.Outline.eraserOutline,
    Redact.Outline.fontStyleOutline,
    Redact.Outline.formatAlignJustifyOutline,
    Redact.Outline.formatPaintOutline,
    Redact.Outline.hideLeftPanelOutline,
    Redact.Outline.hideRightPanelOutline,
    Redact.Outline.indentDecreaseOutline,
    Redact.Outline.indentIncreaseOutline,
    Redact.Outline.leftDoubleOutline,
    Redact.Outline.lineSpacingOutline,
    Redact.Outline.lineThroughOutline,
    Redact.Outline.listBulletedOutline,
    Redact.Outline.listNumberedOutline,
    Redact.Outline.listStyleOutline,
    Redact.Outline.resizeTableOutline,
    Redact.Outline.rightDoubleOutline,
    Redact.Outline.rowDeleteOutline,
    Redact.Outline.rowInsertAfterOutline,
    Redact.Outline.rowInsertBelowOutline,
    Redact.Outline.spellCheckOutline,
    Redact.Outline.tableOutline,
    Redact.Outline.textBoldOutline,
    Redact.Outline.textItalicOutline,
    Redact.Outline.textUnderlineOutline,
    Redact.Outline.txtColorOutline,
    Redact.Solid.eraserSolid,
    Redact.Solid.formatPaintSolid,
    Security.Outline.faceIDOutline,
    Security.Outline.fingerprintOutline,
    Security.Outline.keyOutline,
    Security.Outline.lockOutline,
    Security.Outline.passwordOutline,
    Security.Outline.safetyCertificateOutline,
    Security.Outline.safetyOutline,
    Security.Outline.unlockOutline,
    Security.Solid.faceIDSolid,
    Security.Solid.fingerprintSolid,
    Security.Solid.keySolid,
    Security.Solid.lockSolid,
    Security.Solid.passwordSolid,
    Security.Solid.safetySolid,
    Security.Solid.unlockSolid,
    Service.Outline.agreedOutline,
    Service.Outline.archiveOutline,
    Service.Outline.checkClearOutline,
    Service.Outline.checkOutline,
    Service.Outline.closeCircleOutline,
    Service.Outline.closeOutline,
    Service.Outline.cutOutline,
    Service.Outline.dragOutline,
    Service.Outline.errorOutline,
    Service.Outline.errorTriangleOutline,
    Service.Outline.eyeCloseOutline,
    Service.Outline.eyeOutline,
    Service.Outline.helpOutline,
    Service.Outline.infoOutline,
    Service.Outline.menuOutline,
    Service.Outline.minusCircleOutline,
    Service.Outline.minusOutline,
    Service.Outline.pauseOutline,
    Service.Outline.playOutline,
    Service.Outline.plusCircleOutline,
    Service.Outline.plusOutline,
    Service.Outline.processOutline,
    Service.Outline.sizeChangerHorizontalOutline,
    Service.Outline.sizeChangerVerticalOutline,
    Service.Outline.smallCloseOutline,
    Service.Outline.thumbsDownOutline,
    Service.Outline.thumbsUpOutline,
    Service.Solid.agreedSolid,
    Service.Solid.archiveSolid,
    Service.Solid.checkSolid,
    Service.Solid.closeCircleSolid,
    Service.Solid.closeSolid,
    Service.Solid.cutSolid,
    Service.Solid.dragSolid,
    Service.Solid.errorSolid,
    Service.Solid.errorTriangleSolid,
    Service.Solid.eyeSolid,
    Service.Solid.helpSolid,
    Service.Solid.infoSolid,
    Service.Solid.menuSolid,
    Service.Solid.minusSolid,
    Service.Solid.openShiftSolid,
    Service.Solid.pauseSolid,
    Service.Solid.playSolid,
    Service.Solid.plusCircleSolid,
    Service.Solid.plusSolid,
    Service.Solid.processSolid,
    Service.Solid.smallCloseSolid,
    Service.Solid.thumbsDownSolid,
    Service.Solid.thumbsUpSolid,
    System.Outline.arrowCrossOutline,
    System.Outline.arrowDownOutline,
    System.Outline.arrowLeftOutline,
    System.Outline.arrowRightOutline,
    System.Outline.arrowUpOutline,
    System.Outline.arrowsHorizontalOutline,
    System.Outline.arrowsVerticalOutline,
    System.Outline.atOutline,
    System.Outline.attachFileOutline,
    System.Outline.backOutline,
    System.Outline.barCodeOutline,
    System.Outline.calculateOutline,
    System.Outline.calendarOkOutline,
    System.Outline.calendarOutline,
    System.Outline.calendarUpdateOutline,
    System.Outline.cameraOutline,
    System.Outline.cameraRemoveOutline,
    System.Outline.chevronDownOutline,
    System.Outline.chevronLeftOutline,
    System.Outline.chevronRightOutline,
    System.Outline.chevronUpOutline,
    System.Outline.closeFullscreenOutline,
    System.Outline.darkModeOutline,
    System.Outline.deleteOutline,
    System.Outline.doubleArrowLeftOutline,
    System.Outline.doubleArrowRightOutline,
    System.Outline.downloadOutline,
    System.Outline.editOutline,
    System.Outline.emailOutline,
    System.Outline.emailReadOutline,
    System.Outline.exitOutline,
    System.Outline.exportOutline,
    System.Outline.eyedropperOutline,
    System.Outline.filterOutline,
    System.Outline.homeOutline,
    System.Outline.importOutline,
    System.Outline.inboxOutline,
    System.Outline.keyboardOutline,
    System.Outline.linkOutline,
    System.Outline.loaderOutline,
    System.Outline.moreHorizontalOutline,
    System.Outline.moreOutline,
    System.Outline.moreVerticalOutline,
    System.Outline.notificationsOffOutline,
    System.Outline.notificationsOutline,
    System.Outline.okSendOutline,
    System.Outline.openInFullOutline,
    System.Outline.peopleOutline,
    System.Outline.personAddOutline,
    System.Outline.personLimitsOutline,
    System.Outline.personOutline,
    System.Outline.personPropertiesOutline,
    System.Outline.personRefreshOutline,
    System.Outline.powerOutline,
    System.Outline.printOutline,
    System.Outline.qrCodeOutline,
    System.Outline.redoOutline,
    System.Outline.refuseOutline,
    System.Outline.refuseViewOutline,
    System.Outline.reportOutline,
    System.Outline.saveOutline,
    System.Outline.searchOutline,
    System.Outline.settingsOutline,
    System.Outline.signInOutline,
    System.Outline.smallArrowDownOutline,
    System.Outline.smallArrowLeftOutline,
    System.Outline.smallArrowRightOutline,
    System.Outline.smallArrowUpOutline,
    System.Outline.sortDownOutline,
    System.Outline.sortOutline,
    System.Outline.sortUpOutline,
    System.Outline.starOutline,
    System.Outline.syncForbidOutline,
    System.Outline.syncPermitOutline,
    System.Outline.thirdPersonOutline,
    System.Outline.timeOutline,
    System.Outline.toCustomerOutline,
    System.Outline.tuneOutline,
    System.Outline.undoOutline,
    System.Outline.unlinkOutline,
    System.Outline.updateOutline,
    System.Outline.uploadOutline,
    System.Outline.userDeleteOutline,
    System.Outline.userRoleOutline,
    System.Outline.viewHistoryOutline,
    System.Outline.zoomInOutline,
    System.Outline.zoomOutOutline,
    System.Solid.arrowCrossSolid,
    System.Solid.arrowDownSolid,
    System.Solid.arrowLeftSolid,
    System.Solid.arrowRightSolid,
    System.Solid.arrowUpSolid,
    System.Solid.arrowsHorizontalSolid,
    System.Solid.arrowsVerticalSolid,
    System.Solid.atSolid,
    System.Solid.attachFileSolid,
    System.Solid.backSolid,
    System.Solid.barCodeSolid,
    System.Solid.calculateSolid,
    System.Solid.calendarOkSolid,
    System.Solid.calendarSolid,
    System.Solid.calendarUpdateSolid,
    System.Solid.cameraRemoveSolid,
    System.Solid.cameraSolid,
    System.Solid.chevronDownSolid,
    System.Solid.chevronLeftSolid,
    System.Solid.chevronRightSolid,
    System.Solid.chevronUpSolid,
    System.Solid.closeFullscreenSolid,
    System.Solid.darkModeSolid,
    System.Solid.deleteSolid,
    System.Solid.doubleArrowLeftSolid,
    System.Solid.doubleArrowRightSolid,
    System.Solid.downloadSolid,
    System.Solid.editSolid,
    System.Solid.emailReadSolid,
    System.Solid.emailSolid,
    System.Solid.exitSolid,
    System.Solid.exportSolid,
    System.Solid.eyedropperSolid,
    System.Solid.filterSolid,
    System.Solid.homeSolid,
    System.Solid.importSolid,
    System.Solid.inboxSolid,
    System.Solid.keyboardSolid,
    System.Solid.linkSolid,
    System.Solid.loaderSolid,
    System.Solid.moreHorizontalSolid,
    System.Solid.moreSolid,
    System.Solid.moreVerticalSolid,
    System.Solid.notificationsOffSolid,
    System.Solid.notificationsSolid,
    System.Solid.okSendSolid,
    System.Solid.openInFullSolid,
    System.Solid.peopleSolid,
    System.Solid.personAddSolid,
    System.Solid.personLimitSolid,
    System.Solid.personPropertiesSolid,
    System.Solid.personRefreshSolid,
    System.Solid.personSolid,
    System.Solid.powerSolid,
    System.Solid.printSolid,
    System.Solid.qrCodeSolid,
    System.Solid.redoSolid,
    System.Solid.refuseSolid,
    System.Solid.reportSolid,
    System.Solid.saveSolid,
    System.Solid.searchSolid,
    System.Solid.settingsSolid,
    System.Solid.signInSolid,
    System.Solid.smallArrowDownSolid,
    System.Solid.smallArrowLeftSolid,
    System.Solid.smallArrowRightSolid,
    System.Solid.smallArrowUpSolid,
    System.Solid.sortDownSolid,
    System.Solid.sortSolid,
    System.Solid.sortUpSolid,
    System.Solid.starSolid,
    System.Solid.thirdPersonSolid,
    System.Solid.timeSolid,
    System.Solid.toCustomerSolid,
    System.Solid.tuneSolid,
    System.Solid.undoSolid,
    System.Solid.updateSolid,
    System.Solid.uploadSolid,
    System.Solid.userDeleteSolid,
    System.Solid.userRoleSolid,
    System.Solid.zoomInSolid,
    System.Solid.zoomOutSolid,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
