module HasKind
  extend ActiveSupport::Concern
  included do
    enum kind: {
      Orthopedic: 100,
      FamilyPractice: 200,
      Podiatrist: 300,
      Pediatrician: 400,
      Neurologist: 500,
      Rheumatologist: 600,
      GeneralSurgery: 700,
      OcMed: 800,
      SpineSpecialist: 900,
      Other: 2000
    }, _prefix: true
  end
end
